# S32K Study

## Key Features

* Operation Characteristics

  * HSRUN : -40 ~ 105
  * RUN : -40 ~ 150

* Arm Cortex-M4F/M0+  core, 32bit CPU

  * HSRUN : 122MHz with 1.25 Dhrystone MIPS per MHz
  * Integrated DSP
  * NVIC
  * Singe Precision FPU

* Clock interface

  * 4 ~ 40MHz fast external oscillator
  * ~ 50MHz DC external square input clock in external clock mode
  * 48MHz Fast Internal RC oscillator(FIRC)
  * 8MHz Slow internal RC oscillator(SIRC)
  * 128KHz Low power oscillator(LPO)
  * 112MHz (HSRUN) SPLL
  * TCLK: 20MHz
  * SWD_CLK: 25MHz
  * 32KHz RTC external clock (RTC_CLKIN)

* Power Management

  * PMC with multiple power mode: 
    * HSRUN (112MHz) : CSEc or EEPROM write/erase is invalid
    * RUN (80MHz)
    * STOP
    * VLPR
    * VLPS
  * Clock gating and low power operation supported on ***specific periphrals ?***

* Memory and Memory interfaces

  * 2MB flash with ECC
  * 64K FlexNVM for data flash with ECC and EEPROM emulation
  * 256KB SRAM with ECC
  * 4KB FlexRAM for use as SRAM and EEPROM emulation
  * 4KB ***Code ?***  cache(**ICACHE ?**)
  * QuadSPI with ***HyperBus ?***

* Mixed-signal analog

  * 2 x 12bit ADC with up to 32 channel anaog input per module
  * ***1 x CMP with internal 8-bit DAC ?***  

* ***Debug functionality ?***

  * SWJ-DP
  * DWT (debug watchpoint and Trace)
  * ITM (Instrumentation Trace Macrocell)
  * TPIU (Test Port Interface Unit)
  * FPB (Flash Patch and Breakpoint)

* HMI

  * 156 GPIO with interrupt 
  * NMI

* Communication interfaces

  * 3 x LPUART/ LIN + DMA + low power availablility
  * 3 x LPSPI  + DMA + low power availablility
  * 2 x LPI2C + DMA + low power availablility
  * 3 x FlexCAN
  * 1 x 10/100Mbps Ethernet with IEEE1588 support
  * 2 x SAI (synchronus Audio Interface)

* Safety and Security

  * CSEc (Cryptographic Services Engin) : a comprehensive set of cryptographic functions as described in the SHE (Secure Hardware Extension) Function Specification.
  * 128-bit UID
  * ECC on flash and SRAM
  * System MPU
  * CRC
  * Internal watchdog (WDOG)
  * External WatchDog monitor (EWM) module

* Timing and Control

  * 8  x 16bit FTM(***FlexTimer***), offering up to 64 standard channels(IC/OC/PWM)
  * 1 x 16 bit LPTMR with  flexible ***wake up control***
  * 2 x PDB (programmable delay Blocks) with flexible trigger system
  * 1 x 32 bit ***LPIT ?***(Low power interrupt timer) with 4 channels
  * 32-bit RTC
  * 16 channel DMA with up to 63 request sources using DMAMUX

* Package

  * 32-pin QFN

  * 48-pin QFN

  * 64-pin LQFP

  * 100-pin LQFG

  * 100-pin MAPBGA

  * 144-pin LQFP

  * 176-pin LQFP

    

Block Diagram

![image-20211103190034543](/home/tony/.config/Typora/typora-user-images/image-20211103190034543.png)

