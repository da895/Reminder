## https://www.freertos.org/RTOS-Cortex-M3-M4.html

``` The information regarding interrupt nesting on this page applies when using a Cortex-M3, Cortex-M4, Cortex-M4F, Cortex-M7, and Cortex-M33. It does not apply to Cortex-M23, Cortex-M0 or Cortex-M0+ cores, which do not include a BASEPRI register. ```

*  The RTOS **interrupt nesting** scheme splits the available interrupt priorities into two groups - those that will get masked by RTOS critical sections, and those that are never masked by RTOS critical sections and are therefore always enabled. The *configMAX_SYSCALL_INTERRUPT_PRIORITY* setting in FreeRTOSConfig.h defines the boundary between the two groups.
*  The **preempt priority** defines whether an interrupt can preempt an already executing interrupt.
*  The **sub priority** determines which interrupt will execute first when two interrupts of the same preempt priority occur at the same time
*  
