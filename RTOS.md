## [Running the RTOS on a ARM Cortex-M Core](https://www.freertos.org/RTOS-Cortex-M3-M4.html)

``` The information regarding interrupt nesting on this page applies when using a Cortex-M3, Cortex-M4, Cortex-M4F, Cortex-M7, and Cortex-M33. It does not apply to Cortex-M23, Cortex-M0 or Cortex-M0+ cores, which do not include a BASEPRI register. ```

*  The RTOS **interrupt nesting** scheme splits the available interrupt priorities into two groups - those that will get masked by RTOS critical sections, and those that are never masked by RTOS critical sections and are therefore always enabled. The *configMAX_SYSCALL_INTERRUPT_PRIORITY* setting in FreeRTOSConfig.h defines the boundary between the two groups.
*  The **preempt priority** defines whether an interrupt can preempt an already executing interrupt.
*  The **sub priority** determines which interrupt will execute first when two interrupts of the same preempt priority occur at the same time
*  Therefore, any interrupt service routine that uses an RTOS API function must have its priority manually set to a value that is numerically **equal to or greater than** the *configMAX_SYSCALL_INTERRUPT_PRIORITY* setting. This ensures the interrupt's logical priority is equal to or less than the configMAX_SYSCALL_INTERRUPT_PRIORITY setting. 


## [Debugging Hard Fault & Other Exceptions on ARM Cortex-M3 and ARM Cortex-M4 microcontrollers ](https://www.freertos.org/Debugging-Hard-Faults-On-Cortex-M-Microcontrollers.html)
