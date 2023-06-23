## Tips

*  essential RTOS port specific information
*  how to write FreeRTOS compatible interrupt service routines
*  **Special note to ARM Cortex-M users**: ARM Cortex-M3, ARM Cortex-M4 and ARM Cortex-M4F ports need FreeRTOS handlers to be installed on the SysTick, PendSV and SVCCall interrupt vectors. 
*  The ARM Cortex-M port performs all task context switches in the **PendSV** interrupt
*  Use the *uxTaskGetStackHighWaterMark()* function to see which tasks can be allocated a smaller stack.
*  the *uxTaskGetStackHighWaterMark()* API function can be used to see how much stack has actually been used, allowing the stack size to be reduced if more was allocated than necessary, and the stack overflow detection features can be used to determine if a stack is too small.
*  Use the xPortGetFreeHeapSize() and (where available) the xPortGetMinimumEverFreeHeapSize() API functions to see how much FreeRTOS heap is being allocated but never used, and adjust accordingly. 
*  If heap_1.c, heap_2.c, heap_4.c or heap_5.c are being used, and nothing in your application is ever calling malloc() directly (as opposed to pvPortMalloc()), then ensure the linker is not allocated a heap to the C library because it will never get used.


## [GNU Static Stack Usage Analysis](https://mcuoneclipse.com/2015/08/21/gnu-static-stack-usage-analysis/)

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


