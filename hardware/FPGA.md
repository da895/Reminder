

<!-- vim-markdown-toc GFM -->

* [wait for License](#wait-for-license)
* [Vivado -- Fix routing](#vivado----fix-routing)
  * [1. Fix routing by incremental compile flow](#1-fix-routing-by-incremental-compile-flow)
  * [2. How do I use Vivado's Directed Routing features to lock down my critical paths?](#2-how-do-i-use-vivados-directed-routing-features-to-lock-down-my-critical-paths)
    * [Description](#description)
    * [Solution](#solution)
* rchical design flow](#hierarchical-design-flow)
  * [xilinx 7 series device, pls refer to ug905-vivado-hierarchical-design.pdf](#xilinx-7-series-device-pls-refer-to-ug905-vivado-hierarchical-designpdf)
  * [xilinx UltraScale and beyond, pls refer to ug909-vivado-partial-reconfiguration.pdf](#xilinx-ultrascale-and-beyond-pls-refer-to-ug909-vivado-partial-reconfigurationpdf)
  * [Example scripts for the non-project flow are provided in the `Vivado Design Suite Tutorial: Partial Reconfiguration` (UG947)](#example-scripts-for-the-non-project-flow-are-provided-in-the-vivado-design-suite-tutorial-partial-reconfiguration-ug947)
  * [A question about Pblock](#a-question-about-pblock)
  * [Partial Reconfiguration to reduce Synthesis and Implementation run times for Ultrascale Projects](#partial-reconfiguration-to-reduce-synthesis-and-implementation-run-times-for-ultrascale-projects)
  * [Reserve an empty area](#reserve-an-empty-area)
  * [Hierarchical design, UG905](#hierarchical-design-ug905)
  * [The role of timing constraints is different in synthesis vs. place and route...](#the-role-of-timing-constraints-is-different-in-synthesis-vs-place-and-route)
  * [What are the differences among -physical_exclusive, -logical_exclusive and -asynchronous arguments of set_clock_groups?](#what-are-the-differences-among--physical_exclusive--logical_exclusive-and--asynchronous-arguments-of-set_clock_groups)
* [MISC](#misc)
    * [clock group](#clock-group)
    * [[Problem with RPD (Raw Programming Data File)]https://forums.intel.com/s/question/0D50P00003yyHbmSAE/problem-with-rpd-raw-programming-data-file?language=en_US](#problem-with-rpd-raw-programming-data-filehttpsforumsintelcomsquestion0d50p00003yyhbmsaeproblem-with-rpd-raw-programming-data-filelanguageen_us)
    * [[How to generate .rbf files in Altera Quartus]https://stackoverflow.com/questions/28799960/how-to-generate-rbf-files-in-altera-quartus](#how-to-generate-rbf-files-in-altera-quartushttpsstackoverflowcomquestions28799960how-to-generate-rbf-files-in-altera-quartus)
    * [JTAG+Serial Programmer](#jtagserial-programmer)

<!-- vim-markdown-toc -->

## [wait for License](./misc/waitforlicense.tcl)

https://forums.xilinx.com/t5/Installation-and-Licensing/Waiting-for-floating-license-in-Vivado/td-p/881090

## Vivado -- Fix routing

### 1. Fix routing by incremental compile flow

`lock_design -level routing`

### 2. How do I use Vivado's Directed Routing features to lock down my critical paths?

#### Description

I am attempting to lock down the routing of critical paths in my design and have applied IS_ROUTE_FIXED constraints to do this, but now some of these nets fail to route successfully at all. 

Why is this happening?

#### Solution

Besides capturing a routing constraint, it is also necessary to  ensure that all of the component pins are in the same place so that the  route remains valid. To do this, it is necessary to also control the  Slice location (LOC constraint), BEL location (BEL constraint), and LUT  pin usage (LOCK_PINS constraint). The following commands can be used to capture the necessary constraints using the net names specified by the  TCL variable $net:

1. Routing constraints
   `set_property IS_ROUTE_FIXED 1 [get_nets $net]`
2. LOC constraints
   `set_property IS_LOC_FIXED 1 [get_cells -of [get_nets $net]]`
3. BEL constraints
   `set_property IS_BEL_FIXED 1 [get_cells -of [get_nets $net]] }`
4. LOCK_PINS constraints
   A CR has been filed to request an  "IS_PIN_FIXED" feature. Meanwhile, the following script will apply the  necessary constraints to LUT pins:
    ```tcl
   foreach net $nets {
        puts "Processing net $net"
        set loadpins [get_pins -leaf -of [get_nets $net] -filter direction=~in]
        
        foreach loadpin $loadpins {
            set pin [lindex [split $loadpin /] end]
            set belpin [lindex [split [get_bel_pins -of [get_pins $loadpin]] /] end]
            set index [expr [string length $loadpin] - 4]
            set lut [string range $loadpin 0 $index]
            set beltype [get_bel_pins -of [get_pins $loadpin]]
            
             # Create hash table of LUT names and pin assignments, appending when needed
             if {[regexp (LUT) $beltype]} {if { [info exists lut_array($lut)] } {
                set lut_array($lut) "$lut_array($lut) $pin:$belpin"
              } else {set lut_array($lut) "$pin:$belpin"
        }
       }
    }
    
    foreach lut_name [array names lut_array] {
      puts "Creating LOC_PINS constraint $lut_array($lut_name) for LUT $lut_name."
      set_property LOCK_PINS "$lut_array($lut_name)" [get_cells $lut_name]
   }
    ```

6. write_xdc ./dirt.xdc -force

## hierarchical design flow

### xilinx 7 series device, pls refer to ug905-vivado-hierarchical-design.pdf

### xilinx UltraScale and beyond, pls refer to ug909-vivado-partial-reconfiguration.pdf 

### Example scripts for the non-project flow are provided in the `Vivado Design Suite Tutorial: Partial Reconfiguration` (UG947)

[ug947-vivado-partitial-reconfiguration-turotial](https://forums.xilinx.com/t5/Vivado-TCL-Community/ug947-vivado-partial-reconfiguration-tutorial/m-p/785587#M5831)

[ug947 example](https://forums.xilinx.com/xlnx/attachments/xlnx/Vivado/5831/1/ug947-vivado-partial-reconfiguration-tutorial.zip)

### [A question about Pblock](https://forums.xilinx.com/t5/Implementation/A-question-about-pblock/td-p/893508)

The TCL commands mentioned in my previous post should create a pblock. However, you will need to check if the pblock boundaries defined will be able to place all the cells mentioned in pblock command.

An easy way would be to check from GUI:

 https://www.xilinx.com/video/hardware/design-analysis-floorplanning-with-vivado.html

You can also run `report_utilization -pblock <name_of_pblock>` command. 

https://www.xilinx.com/content/dam/xilinx/support/documentation/sw_manuals/xilinx2018_2/ug906-vivado-design-analysis.pdf

--Syed 

FYI: Did you check this new quick-reference user guide for timing closure? 

https://www.xilinx.com/content/dam/xilinx/support/documentation/sw_manuals/xilinx2018_2/ug1292-ultrafast-timing-closure-quick-reference.pdf

### [Partial Reconfiguration to reduce Synthesis and Implementation run times for Ultrascale Projects](https://forums.xilinx.com/t5/Design-Methodologies-and/Partial-Reconfiguration-to-reduce-Synthesis-and-Implementation/td-p/764868)


For new architectures (UltraScale and beyond), the PR tools are the correct approach for solving hierarchical design flows. The PR flow is very mature, and is much easier to setup/use than the HD flow described in UG905. While it may not meet the need of every design, let me explain how this can be used.

 

First off, OOC (bottom up) synthesis can be used regardless of any HD or PR flow. Our IP use OOC synthesis for this same reason, and there isn't any reason you can't break up your design into OOC modules for synthesis as well. 

 

Once you have the design partitioned into OOC modules, and are saving time on synthesis, you can then decide if the PR tools can help save you time on implementation. The primary supported use case for this is implement a fixed top-level/platform/static, with lower level modules set has HD.RECONFIGURABLE.  These partitions required OOC synthesis (which you'll already be using), as well as Pblocks.  The pblocks need to follow the rules of the PR flow (no overlaps with other partition pblocks, etc), and other PR rules/recommendations should be followed (see UG909 for more information).  

 

If you get the design all setup this way, the PR flow will allow you implement the top-level Platform once, and then choose which revision of the modules you want to plug into the partitions for each run without have to reimplement/re-close timing on the fixed portion of the design. 


Hopefully this flow will fit your needs!

### [Reserve an empty area](https://forums.xilinx.com/t5/Implementation/Reserve-an-empty-area/td-p/738282)

* __PROHIBIT__

The property of _PROHIBIT_ specifies that a BEL or SITE cannot be used for placement.
      

* __EXCLUDE_PLACEMENT__

```tcl
create_pblock <pblock_name>
add_cells_to_pblock [get_pblocks <pblock_name>] -top
resize_pblock [get_pblocks <pblock_name>] -add {SLICE_X0Y0:SLICE_X100Y100}
resize_pblock [get_pblocks <pblock_name>] -add {RAMB18_X0Y0:RAMB18:X2Y20}
set_property EXCLUDE_PLACEMENT TRUE [get_pblocks <pblock_name>]
set_property name pblock_isp [get_pblocks pblock_1]
```

The property of _EXCLUDE_PLACEMENT_ property is used to indicate that the device resources inside of the area defined by a pblock should only be used for logic contained in the Pblock.

I think you can create pblock for those FPGA sites and set the EXCLUDE_PLACEMENT property to TRUE so that the tool does not place other logic in to this pblock. Assign the logic which you want to place in this FPGA region to pblock. You can also have LOC constraint to constrain the logic to specific site within pblock. The LOC constraint would take priority.

### Hierarchical design, UG905

* Bottom-Up Reuse
  top-level design details are not known, so you must supply the **context constraints**, which includes: 

  1. physical location for the module
  2. placement details for the module IO
  3. definitions of clock sources
  4. timing requirements for paths in and out of the module
  5. information about unused IO

  Strongly recommended that the OOC module pins be locked down during the OOC implementation using _HD.PARTPIN_ or _HD.PARTPIN_LOCS_ constraints. Because

  1. A partition pin creates a physical loaction to guide the placement of the associated interface logic. Timing constraints( _set_max_delay_ ) to and from the PartPins are needed to affect placement. 
  2. A partition pin gives the router a point to route the interface subnet. Without PartPins the interface nets cannot be routed, and it is possible to create an OOC result where routes internal to the module  block routing resources needed by the interface nets during reused. This prevents the preservation of all OOC nets without causing an unroutable design. 

* Top-Down Reuse
  the top-level design details (pinout, floorplan, and timing requirements)are known, and are used to guide the OOC implementation.

  1. OOC module pin constraints
  2. top-level input/output timing requirements
  3. boundary optimization constraints

### [The role of timing constraints is different in synthesis vs. place and route...](https://forums.xilinx.com/t5/Timing-Analysis/OOC-synthesis-clock-constraint/td-p/821625)

In synthesis, the constrains help the synthesis tool choose the correct circuit construction. The kinds of decisions here are generally "area vs. speed" type trade-offs; the constraints determine whether the tool can afford the smaller but slower implementation. These would be things like

  - LUT combining

  - resource sharing

  - doing operations in series rather than in parallel if it saves area



These decisions affect the structure of the output netlist.



In place and route, the main roles of the constraints are to guide the tools to make sure that things that are "timing critical" are placed near each other and given more direct routes.



In general a "bad" decision in synthesis cannot be corrected later on. There are some opportunities in the flow to mitigate them; phys_opt_design (assuming it is enabled - it is optional) can do some re-synthesis of critical paths, but the optimizations that are made here are "low level optimizations"; some of the "high level optimizations" that synthesis does first cannot be "fixed" at this stage.



That being said, the reality is that, even with Vivado, the effect of timing constraints on synthesis is fairly minor in many cases; there is rarely a large difference in the structure of the design based on the constraints. This is actually stated (and counted on) in some of the IP strategies that don't use "real" constraints for their OOC synthesis runs.



So, in theory, yes, under-constraining during synthesis can prevent your design from meeting timing even when the proper constraints are used in P&R. However, they probably only do so rarely.



Ultimately, if your design meets timing after implementation, then you are fine. If not, then you should try applying more accurate constraints during the synthesis process. While it probably won't make a difference, you can't be sure until you try it...

### [What are the differences among -physical_exclusive, -logical_exclusive and -asynchronous arguments of set_clock_groups?](https://www.xilinx.com/support/answers/58961.html)

Description
set_clock_groups is used to define asynchronous/exclusive clock groups so that paths between these groups are treated as false paths.

It has three mutually exclusive arguments: -physical_exclusive, -logical_exclusive and -asynchronous.

What are the differences between the three arguments?
Solution
The three clock relationships originated from SDC have different impacts on SI crosstalk analysis.

From an FPGA timing analysis perspective, the impact would be the same.

To more accurately specify the clock relationships, it would be good to understand the different clock interactions.

-asynchronous
When there are valid timing paths between two clock groups but the two clocks do not have any frequency or phase relationship and these timing paths need not to be timed, use -asynchronous.
When there are false timing paths (physically or logically non-existent) between two clock groups, use -physical_exclusive or -logical_exclusive

-logical_exclusive
-logical_exclusive is used for two clocks that are defined on different source roots.
Logically exclusive clocks do not have any functional paths between them, but might have coupling interactions with each other.
An example of logically exclusive clocks is multiple clocks, which are selected by a MUX but can still interact through coupling upstream of the MUX cell.
When there are physically existing but logically false paths between the two clocks, use "set_clock_groups -logical_exclusive".

-physical_exclusive
-physical_exclusive is used for two clocks that are defined on the same source root by "create_clock -add".
Timing paths between these two clocks do not physically exist.
As a result you will need to use "set_clock_groups -physical_exclusive" to set them as false paths.

There is an example of "set_clock_groups" under the Section "Constraining Exclusive Clock Groups" in (UG949).

Please refer to this example which will help you understand the difference between -logical_exclusive and -physical_exclusive.

## MISC
http://www.pldtool.com/pld-file-formats5

https://sourceforge.net/p/openocd/tickets/208/
https://j-marjanovic.io/debugging-linux-start-up-on-altera-cyclone-v-soc-with-openocd.html
https://discourse.myriadrf.org/t/fpga-programming-via-open-source-tools-openocd-svf/3276/21
https://www.esp32.com/viewtopic.php?t=9901
https://docs.espressif.com/projects/esp-idf/en/latest/api-guides/jtag-debugging/


https://www.flashrom.org/FT2232SPI_Programmer

FWIW I find it easier to build openocd for windows (and linux) using the method outlned here rather than Cygwin:

https://github.com/gnu-mcu-eclipse/openocd
https://gnu-mcu-eclipse.github.io/openocd/build-procedure/

Hope this helps.

### clock group

clock  relationship is {A D} {B D} {C D}, the right method show as below

```
set_clock_groups -asynchronous -group {A B C D}
set_clock_groups -asynchronous -group {A} -group {B} -group {C}
```

the wrong method as: 

```
set_clock_groups -asynchronous -group {A D}
set_clock_groups -asynchronous -group {B D}
set_clock_groups -asynchronous -group {C D}
```

### [Problem with RPD (Raw Programming Data File)]https://forums.intel.com/s/question/0D50P00003yyHbmSAE/problem-with-rpd-raw-programming-data-file?language=en_US

you can either write a little program to do the bit-reversal yourself or you can use the following utilities included with the NIOS2 EDS to perform the reversal for you: 

```
"$SOPC_KIT_NIOS2/bin/sof2flash" --epcs --compress --input="my_project.sof" --output="my_project.flash" 
#  Convert to binary
nios2-elf-objcopy -I srec -O binary my_project.flash my_project.bin
```

### [How to generate .rbf files in Altera Quartus]https://stackoverflow.com/questions/28799960/how-to-generate-rbf-files-in-altera-quartus

### [JTAG+Serial Programmer](http://blog.lambdaconcept.com/doku.php?id=products:jtagserial_programmer)

 openocd + FT4232
