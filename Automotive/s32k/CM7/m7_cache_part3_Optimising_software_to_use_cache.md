# Introduction to the ARM® Cortex®-M7 Cache – Part 3 Optimising software to use cache





# Caches – Why do we miss?

## Cold Start

As stated, both data and instruction caches are required to be  invalidated on system start. Therefore, the first load of any object  (code or data) cannot be in cache (thus the cold start condition).

## [![img](m7_cache_part3_Optimising_software_to_use_cache.assets/miss.png)](https://i0.wp.com/feabhasblog.wpengine.com/wp-content/uploads/2020/11/miss.png?ssl=1)

One available technique to help with cold-start conditions is the  ability to pre-load data into the cache. The ARMv7-M instruction set  adds the Preload Data ([PLD](https://developer.arm.com/docs/ddi0597/i/base-instructions-alphabetic-order/pld-pldw-immediate-preload-data-immediate)) instruction. The PLD instruction signals to the memory system that data memory accesses from a specified address are likely shortly. If the  address is cacheable, then the memory system responds by pre-loading the cache line containing the specified address into the cache.  Unfortunately, there is currently no CMSIS intrinsic support for the PLD instruction.

It is worth noting that some processor data caches implement an [**automatic prefetcher**](https://developer.arm.com/documentation/ka001465/1-0?lang=en) (e.g. [Cortex-A15](https://developer.arm.com/ip-products/processors/cortex-a/cortex-a15)). This monitors cache misses, and when a pattern is detected, the automatic prefetcher starts linefills in the background. *Unfortunately, the Cortex-M7 data cache does not support automatic prefetch*.

## Capacity

The other most obvious reason for misses is that of cache capacity.  The larger the cache, the higher the probability of a cache hit and the  lower the frequency of eviction. However, all this comes at a cost, not  only financial but also power.

A larger cache is, naturally, going to contribute to the overall  System-on-Chip (SoC) costs, making the end microprocessor more  expensive. In high volume designs, this is always a significant factor  in SoC choice.

Among all processor components, the cache and memory subsystem  generally consume a large portion of the total microprocessor system  power, commonly 30-50% of the total power [[Zang13](https://feabhasblog.wpengine.com/2020/11/introduction-to-the-arm-cortex-m7-cache-part-3-optimising-software-to-use-cache/#Zang13)]. Caches, thus, add a further level of complexity to the poor-overworked  engineer trying to calculate the design’s power model and has an impact  on all battery-based designs.

## Conflict

Finally, misses will occur due to natural eviction followed by a reload. So a simple loop such as:

```
for(uint32_t i = 0; i < N; ++i) {
   dst[i] = src[i];
}
```

may result in multiple eviction/reload cycles depending on the memory addresses of `dst` and `src`. Also, any `dst[i]` eviction will result in a memory write as the line is marked dirty. The 4-way data cache goes a long way to help reduce the potential of `dst[i]` eviction, but because of the pseudo-random replacement policy, it may happen more often than we would expect or like.

## Code Optimizations

There are a key number of areas where we, as a software developer, can potentially impact the performance of cache:

- Algorithms
- Data structures
- Code structures



## Algorithms

Probably the most common example of demonstrating the impact of  algorithmic code layout and impact on cache performance is loop  interchange.

> ```
> Note: this is one of those, often used, examples, which I dislike. It demonstrates a point, but I doubt any competent programmer would write code this way, nevertheless, I never cease to be amazed by some of the code I sometimes review!
> ```

Take the following code; here was have an array of `50x50` words located in external SDRAM.

```
#define     SIZE 50
extern uint32_t x[SIZE][SIZE];  // located at address 0xC0000000
```

In both examples the loop simply doubles each value in the loop,  however, in the first (inefficient) example, the major index is  incremented first, followed by the minor index, e.g. `x[0][0]`, `x[1][0]`, `x[2][0]`, etc.

```
// cache inefficient example
for(uint32_t j = 0; j < SIZE; ++j) {
  for(uint32_t i = 0 ; i < SIZE; ++i) {
    x[i][j] = 2 * x[i][j];
  }
}
```

If we printed out the addresses of `x[i][j]` we would see the following pattern with 200 bytes (50 words) between each address access.

```
0xC0000000  0xC00000C8  0xC0000190  0xC0000258  ...
```

If we rewrite this loop to follow a more logical model, as in `x[0][0]`, `x[0][1]`, `x[0][2]`, etc., e.g.

```
// cache efficient model
for(uint32_t i = 0; i < SIZE; ++i) {
  for(uint32_t j= 0; j < SIZE; ++j) {
    x[i][j] = 2 * x[i][j];
  }
}
```

And again printed out the addresses of `x[i][j]` we’d see the much more logical and efficient memory accesses of:

```
0xC0000000  0xC0000004  0xC0000008  0xC000000C ...
```

Of course, the actual performance increase will vary depending on  both the cache size and data set, but on an STM32F746 using the [ARM/Keil compiler](https://www2.keil.com/mdk5/compiler/6/), there can be up to an order of magnitude performance improvement between the efficient and inefficient algorithms.

There is another well-documented technique called blocking. Instead  of operating on entire rows or columns of an array, blocked algorithms  operate on sub-matrices or blocks, so that data loaded into the cache  are better reused. The aim is that each chunk should be small enough to  fit all the data for a given computation into the cache, thereby  maximizing data reuse. However, this technique tends to focus on large  data sets using processing platforms with large caches; it is also  susceptible to the [blocking factor](https://en.wikipedia.org/wiki/Loop_nest_optimization).

## Data structures

### Array Merging

We know that spatial locality tends to lead to good cache  performance, but as programs evolve, it is easy to lose sight of the  data locality. Take, for example, the common key/value pairing regularly found in data access. It would be easy to end up with the following  data definitions:

```
// Before
#define     SIZE 50

uint32_t key[SIZE];
uint32_t value[SIZE]; 
```

Typical code access maybe along the lines of:

```
  ...
  if(key[index] == lookup_value) {
    return value[index];
  }
  ...
```

As the key/value pairs are 50 words apart in memory, we will see no  benefit from the cache. However, if we apply the basic principles of  cohesion and merged the data into an appropriate structure, e.g.;

```
// cohesive data structure
typedef struct
{
     uint32_t key;
     uint32_t value; 
} mergedArray_t;

mergedArray_t merged_array[SIZE];
```

with the appropriate changes to the lookup code:

```
  ...
  if(merged_array[index].key == lookup_value) {
     return merged_array[index].value;
  }
  ...
```

We would now expect the value data to be in the same cache line as the key.

This can be improved further by using the [C11 `alignas` directive](https://en.cppreference.com/w/c/language/_Alignas), e.g.

```
#include <stdalign.h>

typedef struct
{
     uint32_t key;
     uint32_t value; 
} mergedArray_t;

alignas(32) mergedArray_t merged_array[SIZE]; // align to 32-byte boundary
```

## Disunited structures

In general software engineering circles, [cohesion](https://en.wikipedia.org/wiki/Cohesion_(computer_science)) (as shown above) is considered good practice.

Unfortunately, it can lead to poor performance when considering cache layout. Take, for example, the following structure and array:

```
#include <stdbool.h>
#include <stdalign.h>

typedef struct {
  double lat;
  double lon;
  double height;
  bool valid;
} Waypoint;

alignas(32) Waypoint track[SIZE];
```

The `sizeof` the `struct` will yield 32-bytes  (matching out cache line length). If we iterate over the array checking  the valid flag, each expression evaluation will require a new cache line fill:

```
  for(unsigned i = 0; i < SIZE; ++i){
    if(track[i].valid){
      // access track[i].lat, etc.
    }
  }
```

If, however, we separate the boolean flag from the structure and create a separate array mapping onto the original array:

```
#include <stdbool.h>
#include <stdalign.h>

typedef struct {
  double lat;
  double lon;
  double height;
} Waypoint;

alignas(32) Waypoint track[SIZE];
alignas(32) bool track_valid[SIZE];
```

giving:

```
  for(unsigned i = 0; i < SIZE; ++i){
    if(track_valid[i]){
      // access track[i].lat, etc.
    }
  }
```

the complete boolean flag array set now fits into one single cache line, improving the hit probability and cache retention.

## Linked-List

Hopefully, it is becoming obvious that for best cache performance we  are looking for sequential, linear, reads of memory where possible.  Unfortunately, one widely used and highly valuable data structure can be very cache unfriendly – the good old [linked-list](https://en.wikipedia.org/wiki/Linked_list). The often-quoted benefits of using a linked list are:

- It has a dynamic data structure
- It can grow and shrink during run time
- Insertion and deletion operations are simple
- More efficient memory utilization than arrays (no need to pre-allocate memory)
- Faster Access time; can be expanded in constant time without memory overhead

Unfortunately, all this flexibility comes at a cost. The strength of  the linked-list is that each member in the list uses pointers to  reference upstream/downstream neighbours. However, these next nodes can  be anywhere in the data memory system, meaning that as we traverse a  linked-list, we shall be jumping around in the address space, and thus  expect a cold start for each node access with possible existing  dirty-line eviction.

## Array Sizes

Arrays, being sequential blocks of memory, are naturally  cache-friendly. Nevertheless, a small difference in the size of an array can have an impact on the cache subsystem. For example, the differences between arrays `a` and `b` appear insignificant.

```
uint32_t a[40];
uint32_t b[50];   
```

But, of course, array `a` is very likely to fit nicely  into five (5) cache lines, but may spill into six (6) depending on the  alignment of the first element. In comparison, the array `b`  is a minimum of seven (7) but could spill into eight (8). The use of  these extra lines, of course, is also evicting what could be other  useful data.

## Code structures

So far, we have been looking at data optimizations for improved cache performance, but we can also address code structure to improve the  instruction cache hit ratio.

## Branching

In the same way that sequential data access is optimal for data cache performance, sequential instruction access is also optimal for  instruction cache performance. Naturally, any code using selection (e.g. if-else, switch statement, etc.) will result in the generation of a  branching operation.

As the processor is executing the current instruction, it is already  fetching and decoding the next instructions into the pipeline ready for  execution. The Cortex-M7 core’s *Prefetch Unit* ([PFU](https://developer.arm.com/documentation/ddi0489/f/introduction/component-blocks/prefetch-unit)) performs these operations. As part of the fetch-cycle, the instruction  cache is pre-populated to guarantee the best performance.

When encountering a conditional branch (i.e. if-else) the prefetch  unit must decide on which branch to follow (branch-prediction) and thus  which instructions will populate instruction cache. In simple terms, the **best performance** is obtained by predicting all  branches not taken and filling the pipeline with the instructions that  follow the branch in the current sequential path.

However, as with the Cortex-M7, where we encounter longer pipelines  and L1 cache, this simple prediction model is inefficient. Therefore,  the Cortex-M7 prefetch unit includes a *Branch Target Address Cache* ([BTAC](https://developer.arm.com/documentation/ddi0406/b/System-Level-Architecture/Common-Memory-System-Architecture-Features/Caches/Branch-predictors)). The BTAC provides dynamic prediction of branches (including Branch-Link, [BL](https://developer.arm.com/documentation/dui0801/j/A32-and-T32-Instructions/BL), instructions) by storing the existence of branches at particular  locations in memory, and using a simple state model, predicts branch  flow.

Nevertheless, when writing code, it is worth bearing in mind the potential impact of branches on cache performance.

## Inlining

Embedded C compilers supported the ability to inline functions long before they were standardized in C++98 and [C99](https://en.cppreference.com/w/c/language/inline). The intent of marking a function for inlining is to hint to the  compiler that it is worth substituting the code of the function into its caller rather than branching to it. As well as eliminating the need for a call and return sequence (BL and [BX](https://developer.arm.com/documentation/100069/0602/A32-and-T32-Instructions/BX) operations), it allows the compiler to perform specific optimizations  (typically to remove stack usage and improve register usage) between the bodies of both functions.

One of the trade-offs between inline and out-of-line functions is the performance/memory consideration, insomuch as inlining will typically  give better performance. In contrast, out-of-lining reduces image size  by only having a single instance of the function code, rather than  repeating the code in the image at each function call site.

Once we introduce an instruction cache, we have several further  considerations. An out-of-line instance has a single fixed address in  memory, so will always appear at the same cache lines and once called  will stay in cache until evicted. Whereas all inlined functions will  each appear at a differing address in the memory map, thus always  requiring cold-starts and occupying multiple cache lines (and  consequently evicting other, potentially useful, code). The out-of-line  instance will have been prefetched by the PFU/BTAC, also reducing  out-of-line overheads.

So, counter-intuitively, using inlining can be detrimental to  performance when a core supports an instruction cache. As always, you  should only ever be using inlining where you are profiling the code  (ideally utilizing the [Cortex-M7 ETM](https://developer.arm.com/documentation/ddi0494/d/introduction/about-the-coresight-etm-m7/the-coresight-debug-environment)) and demonstrating a performance need and showing a performance gain.

## Non-Cachable Memory

The ARM architecture always splits memory into three different memory types:

- Normal
- Device
- Strongly Ordered (SO)

As stated, the default ARMv7-M memory model is split into eight 500MB regions, with each address range mapped to one of the memory types.

**Normal** memory is suitable for main application  memory, e.g., ROM, RAM, Flash and SDRAM. Caches and write buffers are  permitted to work alongside Normal memory.

**Device** and **Strongly Ordered** memory  are always Non-cacheable. The main difference between Device and  Strongly Ordered memory is Device memory writes may be buffered.

## Memory Protection Unit (MPU)

When an MPU is present, it provides basic memory management through  the concept of regions (MPU “pages” are called regions; this is to avoid confusion between MMU and MPU). An MPU region has:

- Base Address
- Size
- Attributes (Cacheable policy and Sharable)
- Memory Type (Normal, Device, SO)
- Access Control (e.g. read-only, read-write, etc.)

The memory system can **cache** any **Normal** memory address marked as either:

- Cacheable, Non-shareable, Write-Back, Read-Allocate, Write-Allocate
- Cacheable, Non-shareable, Write-Back, Read-Allocate only
- Cacheable, Non-shareable, Write-Through, Read-Allocate only

*Previous blog:* 

https://feabhasblog.wpengine.com/2013/02/setting-up-the-cortex-m34-armv7-m-memory-protection-unit-mpu/

## Multiple Bus Masters

Where we have multiple bus masters (e.g. a [DMA controller](https://en.wikipedia.org/wiki/Direct_memory_access)), runtime cache maintenance operations may be required. For example,  sharing a cacheable memory location between the processor and a DMA  Controller for buffering:

- If the memory location updated by the Cortex-M7 processor, is being  used as a write-buffer and has to be accessed by another bus master, a  cache clean is needed to ensure the other bus master can see the new  data.
- If the memory location is acting as a read-buffer and updated by a  different bus master, the Cortex-M7 processor must do a cache invalidate so that next time it reads the memory location, it will fetch the  information from the main memory system.

An alternative (simpler) approach is to mark a region of the RAM used by the multiple-bus masters (i.e. the buffer) as **sharable**, ensuring the memory is never cached (but obviously with a performance hit).

## Other considerations

### Sleep State

When the processor is powered down to preserve power, before the  power down, the data cache should be cleaned. Some cores support  different sleep modes; one where the cache is left powered (sleep) and  one where it is not (deep sleep). If multiple sleep modes are supported, cache cleaning is only required when power is being gated from the data cache.

### Memory barriers

With the support for multiple bus interfaces and write buffers in the Cortex-M7 processor; when writing code that is intrinsically memory  access dependent (e.g. operating system, driver-level code) you might  find that you need to insert additional memory barrier instructions in  your program code. The guide for memory barrier usage can be found in  the ARM application note [AN321 – ARM Cortex-M Programming Guide to Memory Barrier Instructions ](https://developer.arm.com/documentation/dai0321/a/)and is beyond the scope of this discussion.

### Tightly Coupled Memory (TCM)

The design of the TCM is to provide low-latency memory (typically using SRAM) similar to a cache. It is, effectively, **Direct-Mapped Cache** locked down to a fixed address range. Note, however, that the TCM  memory contents are not cached. The TCM memory is directly connected to  the Cortex-M7 core by a bus. The access speeds are similar to accessing  cache but without the penalty of a cache-miss and cache coherence  issues.

Due to the Harvard architecture, as with a cache, the Cortex-M7 has separate TCMs for instructions (ITCM) and data (DTCM). The **ITCM** has one 64-bit memory interface, and the **DTCM** has two 32-bit memory interfaces, D0TCM and D1TCM. The TCMs are  optional but if present, can range from 4KB to a maximum of 16MB.

Applications typically use the ITCM to hold the Exception Vector  Table, critical routines, such as interrupt handling routines and  real-time tasks where the indeterminacy of a cache is highly  undesirable. Also, real-time operating systems (RTOS) may use the DTCM  to store critical data structures (e.g. the ready list) and the  Cortex-M7’s Main Stack Pointer (MSP); used for exception handling.

The TCMs offer one further benefit over a cache in that they can be  accessed directly using DMA, so are a better candidate for shared bus  master buffers than main memory.

### Image placement

One of the final optimizations we may need to improve cache  performance is to adjust the image layout due to cache address  conflicts. We have discussed several potential cases where address  clashes may lead to premature eviction and possible cache thrashing.

In a simpler system where we may only have FLASH and RAM we would not have to worry too much about the detail of the image layout, focusing  on the major segments, such as stack, heap and statics.

With the memory system of processors such as the Cortex-M7, we now  need to think much more carefully about where parts of the image map  reside, especially relating to the ITCM and DTCM. For all of the image  not residing in the TCMs, then we may want to profile the code and  analyze cache performance. Image reordering is a detailed optimization  stage, where you are looking to squeeze more cycles out of the  processor.

Unfortunately, any fine optimizations make may need to be reapplied  for any revision of the image (e.g. bug fix or feature enhancement).

# Summary

The introduction of the Cortex-M7 architecture to the ARMv7-M family  has brought with it many features typically only found on higher-end  processors such as the Cortex-A family, such as long pipelines, TCM,  Cache, PFU, Write-back-buffers, etc. With this brings a significant  performance improvement over previous ARMv7-M cores (typically in the  order of x2 performance gain over the Cortex-M4) and outperforming  higher-end cores such as the Cortex-R5 [[ARM1](https://feabhasblog.wpengine.com/2020/11/introduction-to-the-arm-cortex-m7-cache-part-3-optimising-software-to-use-cache/ARM1)].

However, all this comes at the cost of added complexity. Application  programmers, and specifically firmware programmers, will need to be much more aware of the Cortex-M7’s memory system to get the most out of the  core. Care is needed when working with multiple bus masters (such as  DMA) and ideally, any RTOS will also have been adapted to utilize the  advanced features of the Cortex-M7.

Finally, we need to be aware of what constitutes cache-friendly code and data.

References
 [ Zang13] Wei Zang and Ann Gordon-Ross. 2013. A survey on cache tuning from a power/energy perspective. *ACM Comput. Surv.* 45, 3, Article 32 (June 2013), 49 pages. DOI:[https://doi.org/10.1145/2480741.2480749](https://dl.acm.org/doi/10.1145/2480741.2480749)

[ ARM1] ARM® Cortex® -M7: Bringing High Performance to the Cortex-M Processor Series
 Ian Johnson Senior Product Manager, ARM. [PDF](https://www.armtechforum.com.cn/2014/sh/B-1_BringingHighPerformancetotheCortex-MProcessorSeries.pdf)