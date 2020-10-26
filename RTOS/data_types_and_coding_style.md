# Data Types and Coding Style Guide

### Data Types

Standard data types other than ‘char’ are not used (see below), instead type names defined within the  compiler’s stdint.h header file are used. ‘char’ types are only  permitted to point to ASCII strings or reference single ASCII  characters.

### Variable Names

Variables are prefixed with their type: **‘c’ for char, ‘s’ for short, ‘l’ for long, and ‘x’ for BaseType_t and any  other types (structures, task handles, queue handles, etc.). If a  variable is unsigned, it is also prefixed with a ‘u’. If a variable is a pointer, it is also prefixed with a ‘p’. Therefore, a variable of type  unsigned char will be prefixed with ‘uc’, and a variable of type pointer to char will be prefixed with ‘pc’.**

### Function Names

Functions are prefixed with both the type they return and the file they are defined in. For example:

- vTaskPrioritySet() returns a void and is defined within task.c.
- xQueueReceive() returns a variable of type BaseType_t and is defined within queue.c.
- vSemaphoreCreateBinary() returns a void and is defined within semphr.h

File scope (private) functions are prefixed with ‘prv.

### Macro Names

Most macros are written in upper case and prefixed with lower case letters  that indicate where the macro is defined. Table 4 provides a list of  prefixes.

| Prefix                                     | Location of macro definition |
| ------------------------------------------ | ---------------------------- |
| port (for example, portMAX_DELAY)          | portable.h                   |
| task (for example, taskENTER_CRITICAL())   | task.h                       |
| pd (for example, pdTRUE)                   | projdefs.h                   |
| config (for example, configUSE_PREEMPTION) | FreeRTOSConfig.h             |
| err (for example, errQUEUE_FULL)           | projdefs.h                   |

1. [^](https://zhuanlan.zhihu.com/p/480328008#ref_1_0)FreeRTOS_Reference_Manual_V10.0.0.pdf(page 394)) https://www.freertos.org/fr-content-src/uploads/2018/07/FreeRTOS_Reference_Manual_V10.0.0.pdf
