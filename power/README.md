Power Board Design
=================


<!-- vim-markdown-toc GFM -->

* [INA301 36V High-Speed, zero-drift, voltage-output, current-shunt monitor with higg-speed, overcurrent comparator](#ina301-36v-high-speed-zero-drift-voltage-output-current-shunt-monitor-with-higg-speed-overcurrent-comparator)
* [Simplifying current sense](#simplifying-current-sense)
* [AN-105: Current Sense Circuit Collection Making sense of Current](#an-105-current-sense-circuit-collection-making-sense-of-current)
* [High-side Current Sensing with Wide Dynamic Range:Tree solutions](#high-side-current-sensing-with-wide-dynamic-rangetree-solutions)
* [Automotive, mA-to-kA range, Current Shunt Sensor Reference design](#automotive-ma-to-ka-range-current-shunt-sensor-reference-design)
* [INA229, 85V， 20-Bit, Ultra-Precise Power/Energy/Charge Monitor with SPI interface](#ina229-85v-20-bit-ultra-precise-powerenergycharge-monitor-with-spi-interface)
* [TPS61585 EVM kit fail: The USB-to-GPIO adapter gets bricked by the TPS65185 software](#tps61585-evm-kit-fail-the-usb-to-gpio-adapter-gets-bricked-by-the-tps65185-software)
* [PMBus™ MonitoringGraphical User InterfaceUser’s Guide](#pmbus-monitoringgraphical-user-interfaceusers-guide)
* [PMBus stack user guide](#pmbus-stack-user-guide)
* [TI usb 2 gpio](#ti-usb-2-gpio)
* [USB Interface Adapter Evaluation Module User Guide](#usb-interface-adapter-evaluation-module-user-guide)
* [Implementing Robust PMBus System Software for the LTC3880](#implementing-robust-pmbus-system-software-for-the-ltc3880)
* [Direct Format Usage for PMBusData Transfer](#direct-format-usage-for-pmbusdata-transfer)
* [PMBUS Spec](#pmbus-spec)

<!-- vim-markdown-toc -->

## [INA301 36V High-Speed, zero-drift, voltage-output, current-shunt monitor with higg-speed, overcurrent comparator](https://www.ti.com/product/INA301-Q1?keyMatch=&tisearch=search-everything&usecase=partmatches) 

## [Simplifying current sense](./slyy154a.pdf)

## [AN-105: Current Sense Circuit Collection Making sense of Current](./an-105fa.pdf)

## [High-side Current Sensing with Wide Dynamic Range:Tree solutions](./high-side-current-sensing-wide-dynamic-range.pdf)

## [Automotive, mA-to-kA range, Current Shunt Sensor Reference design](./tidud33a.pdf)

## [INA229, 85V， 20-Bit, Ultra-Precise Power/Energy/Charge Monitor with SPI interface](./ina229-q1.pdf)

## [TPS61585 EVM kit fail: The USB-to-GPIO adapter gets bricked by the TPS65185 software](https://e2e.ti.com/support/power-management/f/power-management-forum/423703/tps65185-evm-kit-fail-the-usb-to-gpio-adapter-gets-bricked-by-the-tps65185-software)

<pre>
    ATTENTION: Need reboot Windows 10 with enable install drivers without digital signature !
    
    0. Disconnect HPA172 (brick)
    1. Download from TI sllc160a.zip
    2. Unpack and install it (C:\TI\TI USB Apploader Drivers)
    3. Download attached file HPA172.bin and copy it to installed AppLoader folder amd64 (for 64) or x86 (for 32)
    
    so you have 3 files in amd64 (or x86) folder
    
    ApLoader.sys
    Apploader.inf
    HPA172.bin
    
    <a href="https://e2e.ti.com/cfs-file/__key/communityserver-discussions-components-files/196/HPA172.zip">/cfs-file/__key/communityserver-discussions-components-files/196/2476.HPA172.zip</a>
    
    4. Open  Apploader.inf in text editor and replace text TUSBXXXX.BIN to HPA172.bin
    5. Connect your brick HPA172 to computer, open Device Manager and see unknown device with USB\VID_0451&PID_2136
    6. Click Update driver, browse for drivers C:\TI\TI USB Apploader Drivers\amd64 (or x86), Agree with install unsigned driver.
    7. After complete installation, reconnect HPA172 and see HID device with HID\VID_0451&PID_5F00
    8. Start TPS65185.exe
    
    Best regards
    Mitek
    
    P.S. After complete check you can recovery EEPROM via USB-TO-GPIO Firmware Loader
    
    and original HPA172-FW 1.0.11
    
    <a href="https://e2e.ti.com/cfs-file/__key/communityserver-discussions-components-files/196/HPA172_2D00_1.0.11.zip">/cfs-file/__key/communityserver-discussions-components-files/196/7266.HPA172_2D00_1.0.11.zip</a>
    
    Start USB-TO-GPIO Firmware Loader.exe
    Load image HPA172-1.0.11.BIN
    and Update.
    
    Now you can remove AppLoader drivers (via Device Manager - View hidden devices in Other devices group) and enable driver signature back.
    
    P.P.S. TI need fix file EEProm Image 1.0.11 (gpio write fix)
    Need remove first 4 bytes.
</pre>

## [PMBus™ MonitoringGraphical User InterfaceUser’s Guide](ww1.microchip.com/downloads/en/DeviceDoc/50002380A.pdf)

## [PMBus stack user guide](http://ww1.microchip.com/downloads/en/devicedoc/41361a.pdf)

## [TI usb 2 gpio](https://www.ti.com/tool/USB-TO-GPIO#tech-docs)
    
   [TUSB3210 Datasheet](./tusb3210.pdf)
   [TUSB3210 EVB](./sllu031a.pdf)
   [TUSB3210 bootcode](./sllu025a.pdf)

## [USB Interface Adapter Evaluation Module User Guide](https://www.ti.com/lit/ml/sllu093/sllu093.pdf?ts=1615900255365&ref_url=https%253A%252F%252Fwww.ti.com%252Ftool%252FUSB-TO-GPIO)

## [Implementing Robust PMBus System Software for the LTC3880](https://www.analog.com/media/en/technical-documentation/application-notes/an135f.pdf)

## [Direct Format Usage for PMBusData Transfer](https://pmbus.org/Assets/Present/2017_APEC_PMBus_Direct_Data_Xfer_Format.pdf)

## [PMBUS Spec](https://pmbus.org/Specifications/OlderSpecifications)

   ### PMBUS 1.2
   * [part 1](https://pmbus.org/Assets/PDFS/Public/PMBus_Specification_Part_I_Rev_1-2_20100906.pdf)
   * [part 2](https://pmbus.org/Assets/PDFS/Public/PMBus_Specification_Part_II_Rev_1-2_20100906.pdf)
