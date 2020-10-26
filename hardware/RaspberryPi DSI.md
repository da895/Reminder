
Table of Contents
=================

<!-- vim-markdown-toc GFM -->

* [4.3inches DSI LCD from Waveshare](#43inches-dsi-lcd-from-waveshare)
    * [Introduction](#introduction)
    * [Features](#features)
    * [Hardware connection](#hardware-connection)
    * [Software setting](#software-setting)
    * [Rotation](#rotation)
    * [Install virtual keyboard](#install-virtual-keyboard)
* [DSI Driver](#dsi-driver)
* [Raspberry Pi hardware](#raspberry-pi-hardware)
* [Raspberry Pi  Pinout](#raspberry-pi--pinout)
* [Topic of Raspberry Pi display](#topic-of-raspberry-pi-display)
* [Raspberry Pi  Display connector reference1](#raspberry-pi--display-connector-reference1)
* [P/N of SFW15R-2STE1LF for Display connector](#pn-of-sfw15r-2ste1lf-for-display-connector)
* [P/N of 1-1734248-5 according to Raspberry schematic](#pn-of-1-1734248-5-according-to-raspberry-schematic)

<!-- vim-markdown-toc -->

# [4.3inches DSI LCD from Waveshare](https://www.waveshare.com/wiki/4.3inch_DSI_LCD)

![IMAGE WHAT](/misc/WaveShare_DSI_4p3inches_panel_Exterior-Size.jpg)

## Introduction

4.3inch Capacitive Touch Display for Raspberry Pi, 800×480, IPS Wide Angle, MIPI DSI Interface
Features

## Features

    - 4.3inch IPS screen. 800x480 hardware resolution
    - Capacitive touch panel, support 5-point touch
    - Supports Pi 4B/3B+/3A+/3B/2B/B+/A+. Another adapter board is required for CM3/3+
    - DSI interface, refresh rate up to 60Hz.
    - Supports Raspbian/Ubuntu/Kali and WIN 10 IoT, driver free.
    
## Hardware connection

    - Connect the DSI interface of 4.3inch DSI LCD to the DSI interface of Raspberry Pi.
    - For easy use, you can fix the Raspberry Pi on the backside of the 4.3inch DSI LCD by screws
    
## Software setting

1) Download image (Raspbian, Ubuntu, Kali, or WIN 10 IOT) from the Raspberry Pi website. https://www.raspberrypi.org/downloads/

2) Download the compressed file to the PC, and unzip it to get the .img file.

3) Connect the TF card to the PC, use SDFormatter.exe software to format the TF card.

4) Open the Win32DiskImager.exe software, select the system image downloaded in step 2, and click‘Write’ to write the system image.

5) After the image has finished writing, save and quit the TF card safely.

6) Power on the Raspberry Pi and wait for a few seconds until the LCD displays normally. And the touch function can also work after the system starts. 

## Rotation  

To change the orientation of the display, you can modify /boot/config.txt file as below 
  - Open the file 
  `sudo nano /boot/config.txt`
  - Add the following code at the end of config.txt 
    * Rotate 90 degrees
    ```
    display_lcd_rotate=1
    dtoverlay=rpi-ft5406,touchscreen-swapped-x-y=1,touchscreen-inverted-x=1
    ```
    * Rotate 180 degrees
    ```
    display_lcd_rotate=2
    dtoverlay=rpi-ft5406,touchscreen-swapped-x-y=1,touchscreen-inverted-x=1
    ```
    * Rotate 270 degrees
    ```
    display_lcd_rotate=3
    dtoverlay=rpi-ft5406,touchscreen-swapped-x-y=1,touchscreen-inverted-x=1
    ```
    
    If you use Raspberry Pi 4, you need to remove the line: dtoverlay=cv4-fkms-V3D
    
  - Save and reboot Raspberry Pi 
    `sudo reboot`
    
## Install virtual keyboard

Open terminal and install it by the following command

`sudo apt-get install matchbox-keyboard`

After installing, you can click Accessories -> Keyboard to open the keyboard. 

# DSI Driver

- [WaveShare Touchscreen driver](https://github.com/waveshare/LCD-show.git)

- [Setup a custom MIPI DSI Display Driver workflow](https://github.com/raspberrypi/linux/issues/2855)

- [CM3+ with custom display problems](https://www.raspberrypi.org/forums/viewtopic.php?f=98&t=240389#p1467185)

- [Demystifying Linux MIPI-DSI Subsystem](https://elinux.org/images/7/73/Jagan_Teki_-_Demystifying_Linux_MIPI-DSI_Subsystem.pdf) 
  - [Local Documents](/misc/Jagan_Teki_-_Demystifying_Linux_MIPI-DSI_Subsystem.pdf)

- **ICN6211**
  - [drm/bridge: Add Chipone ICN6211 MIPI-DSI/RGB convertor bridge](https://lore.kernel.org/patchwork/patch/1051091/)
  - [drm/panel: Add Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge](https://patchwork.freedesktop.org/patch/334089/?series=60847&rev=2)


- **ILI9881C**
    - [Driver IC of ILI9881C](http://www.internetsomething.com/lcd/ILI9881C-3lane-mipi-gramless.pdf)
    - [RaspberryPi Linux Driver for ILI9881c](https://github.com/raspberrypi/linux/blob/rpi-4.20.y/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c) 
      - [Local Documents](/misc/ILI9881C-3lane-mipi-gramless.pdf)

- **OTM8009A**
    - [RaspberryPi Linux Driver for OTM8009A](https://github.com/raspberrypi/linux/blob/rpi-4.20.y/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c)
    - [Local Documents](/misc/OTM8009A.pdf) http://www.orientdisplay.com/pdf/OTM8009A.pdf

- **OTM8009A**
    - [RaspberryPi Linux Driver for OTM8009A](https://github.com/raspberrypi/linux/blob/rpi-4.20.y/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c)
      - [Local Documents](/misc/OTM8009A.pdf) http://www.orientdisplay.com/pdf/OTM8009A.pdf

- [Device Trees, overlays, and parameters of RaspberryPI](https://www.raspberrypi.org/documentation/configuration/device-tree.md)

# [Raspberry Pi hardware](https://www.raspberrypi.org/documentation/hardware/raspberrypi/README.md)

# [Raspberry Pi  Pinout](https://pinout.xyz/pinout/i2c#)

# [Topic of Raspberry Pi display](https://www.raspberrypi.org/forums/viewtopic.php?t=74656)

# [Custmon MIPI DSI panel -dsi work but the display is always black](https://www.raspberrypi.org/forums/viewtopic.php?t=279292)

# [Raspberry Pi  Display connector reference1](https://github.com/da895/documentation/blob/master/hardware/computemodule/schematics/rpi_SCH_CMCDA_1p1.pdf)

# [P/N of SFW15R-2STE1LF for Display connector](https://www.digikey.co.uk/product-detail/en/amphenol-fci/SFW15R-2STE1LF/609-1906-1-ND/1003189)

# [P/N of 1-1734248-5 according to Raspberry schematic](/misc/1-1734248-5.pdf)

  
