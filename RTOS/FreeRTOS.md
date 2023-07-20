
## TODO

* RTOS Task Notifications 


## Tips

*  essential RTOS port specific information
*  how to write FreeRTOS compatible interrupt service routines
*  **Special note to ARM Cortex-M users**: ARM Cortex-M3, ARM Cortex-M4 and ARM Cortex-M4F ports need FreeRTOS handlers to be installed on the SysTick, PendSV and SVCCall interrupt vectors. 
*  The ARM Cortex-M port performs all task context switches in the **PendSV** interrupt
*  Use the *uxTaskGetStackHighWaterMark()* function to see which tasks can be allocated a smaller stack.
*  the *uxTaskGetStackHighWaterMark()* API function can be used to see how much stack has actually been used, allowing the stack size to be reduced if more was allocated than necessary, and the stack overflow detection features can be used to determine if a stack is too small.
*  Use the xPortGetFreeHeapSize() and (where available) the xPortGetMinimumEverFreeHeapSize() API functions to see how much FreeRTOS heap is being allocated but never used, and adjust accordingly. 
*  If heap_1.c, heap_2.c, heap_4.c or heap_5.c are being used, and nothing in your application is ever calling malloc() directly (as opposed to pvPortMalloc()), then ensure the linker is not allocated a heap to the C library because it will never get used.
*  A consequence of always running the highest priority task that is able to run is that a high priority task that never enters the [Blocked or Suspended](https://www.freertos.org/RTOS-task-states.html) state will permanently starve all lower priority tasks of any execution time.  it is best to create tasks that are event-driven.
*  Low priority numbers denote low priority tasks. The idle task has priority zero (tskIDLE_PRIORITY).
*  Binary semaphores and mutexes are very similar but have some subtle differences: Mutexes include a priority inheritance mechanism, binary semaphores do not.  Whereas binary semaphores are the better choice for implementing synchronisation (between tasks or between tasks and an interrupt), mutexes are the better choice for implementing simple mutual exclusion (hence 'MUT'ual 'EX'clusion).
*  Mutexes should not be used from an interrupt
*  FreeRTOS Stream and Message Buffers use the task notification at array index 0
*  heap_1.c for simplicity and determinism often necessary for safety critical applications, heap_4.c for fragmentation protection, heap_5.c to split the heap across multiple RAM regions
*  A full interrupt nesting model is achieved by setting configMAX_SYSCALL_INTERRUPT_PRIORITY **above** (that is, at a higher priority level) than configKERNEL_INTERRUPT_PRIORITY. **This means the FreeRTOS kernel does not completely disable interrupts, even inside critical sections**.


## [GNU Static Stack Usage Analysis](https://mcuoneclipse.com/2015/08/21/gnu-static-stack-usage-analysis/)

* -fstack-usage  -Wstack-usage=256
* Notice the INTERRUPT entry: it is the level of stack needed by the interrupts. The tool assumes non-nested interrupts: it counts the worst case Interrupt Vector (IV) stack usage to the peak execution


## task

Task States

A task can exist in one of the following states:

* **Running**

When a task is actually executing it is said to be in the Running state. It is currently utilising the processor. If the processor on which the RTOS is running only has a single core then there can only be one task in the Running state at any given time.

* **Ready**

Ready tasks are those that are able to execute (they are not in the Blocked or Suspended state) but are not currently executing because a different task of equal or higher priority is already in the Running state.

* **Blocked**

A task is said to be in the Blocked state if it is currently waiting for either a temporal or external event. For example, if a task calls vTaskDelay() it will block (be placed into the Blocked state) until the delay period has expired - a temporal event. Tasks can also block to wait for queue, semaphore, event group, notification or semaphore event. Tasks in the Blocked state normally have a 'timeout' period, after which the task will be **timeout**, and be unblocked, even if the event the task was waiting for has not occurred.

Tasks in the Blocked state do not use any processing time and cannot be selected to enter the Running state.

* **Suspended**

Like tasks that are in the Blocked state, tasks in the Suspended state cannot be selected to enter the Running state, but tasks in the Suspended state **do not** have a time out. Instead, tasks only enter or exit the Suspended state when explicitly commanded to do so through the vTaskSuspend() and xTaskResume() API calls respectively.

![image](https://www.freertos.org/fr-content-src/uploads/2018/07/tskstate.gif)

## [Running the RTOS on a ARM Cortex-M Core](https://www.freertos.org/RTOS-Cortex-M3-M4.html)

``` The information regarding interrupt nesting on this page applies when using a Cortex-M3, Cortex-M4, Cortex-M4F, Cortex-M7, and Cortex-M33. It does not apply to Cortex-M23, Cortex-M0 or Cortex-M0+ cores, which do not include a BASEPRI register. ```

*  The RTOS **interrupt nesting** scheme splits the available interrupt priorities into two groups - those that will get masked by RTOS critical sections, and those that are never masked by RTOS critical sections and are therefore always enabled. The *configMAX_SYSCALL_INTERRUPT_PRIORITY* setting in FreeRTOSConfig.h defines the boundary between the two groups.
*  The **preempt priority** defines whether an interrupt can preempt an already executing interrupt.
*  The **sub priority** determines which interrupt will execute first when two interrupts of the same preempt priority occur at the same time
*  Therefore, any interrupt service routine that uses an RTOS API function must have its priority manually set to a value that is numerically **equal to or greater than** the *configMAX_SYSCALL_INTERRUPT_PRIORITY* setting. This ensures the interrupt's logical priority is equal to or less than the configMAX_SYSCALL_INTERRUPT_PRIORITY setting. 


## [Debugging Hard Fault & Other Exceptions on ARM Cortex-M3 and ARM Cortex-M4 microcontrollers ](https://www.freertos.org/Debugging-Hard-Faults-On-Cortex-M-Microcontrollers.html)

## configASSERT

 * An assertion is triggered if the parameter passed into configASSERT() is zero. 
 * Note defining configASSERT() will increase both the application code size and execution time. When the application is **stable** the additional overhead can be removed by simply commenting out the configASSERT() definition in FreeRTOSConfig.h.


## Reference 

* https://bbs.huaweicloud.com/blogs/378545 

