
## Doc
 http://openocd.org/doc/doxygen/html/armv8_8c_source.html

## [raspberry-pi-3 with openocd](https://sysprogs.com/w/forums/topic/raspberry-pi-3-with-openocd/)


##  [Day 04 OpenOCD common cmd](https://ithelp.ithome.com.tw/articles/10193006)

## [building OpenOCD under Windows using MSYS2]( https://www.playembedded.org/blog/building-openocd-under-windows-using-msys2/)

    https://github.com/Alexpux/MINGW-packages.git
    
    https://github.com/msys2/MINGW-packages/blob/master/mingw-w64-openocd-git/PKGBUILD
    
    ``` 
    depends=("${MINGW_PACKAGE_PREFIX}-hidapi"
              "${MINGW_PACKAGE_PREFIX}-libusb"
              "${MINGW_PACKAGE_PREFIX}-libusb-compat"
              "${MINGW_PACKAGE_PREFIX}-libftdi"
              "${MINGW_PACKAGE_PREFIX}-libjaylink")
     makedepends=("${MINGW_PACKAGE_PREFIX}-gcc"
              "${MINGW_PACKAGE_PREFIX}-pkg-config"
              "git")
    
    prepare() {
      cd "${srcdir}"/${_realname}
      ./bootstrap
    }
    
    build() {
      cd "${srcdir}"/${_realname}
    
      ./configure \
        --prefix=${MINGW_PREFIX} \
        --{build,host}=${MINGW_CHOST} \
        --disable-dependency-tracking \
        --disable-werror \
        --disable-internal-libjaylink \
        --enable-dummy \
        --enable-jtag_vpi \
        --enable-remote-bitbang \
        --enable-amtjtagaccel \
        --enable-gw16012 \
        --enable-parport \
        --enable-parport-giveio
    
        make
    }
    ```
      
    below list the cmd
    
    ```
    ./configure --host=i686-w64-mingw32 --build=i686-w64-mingw32 --disable-werror --disable-dependency-tracking --enable-ftdi  --enable-dummy  --enable-stlink  --enable-ti-icdi --enable-ulink  --enable-usb-blaster-2 --enable-ft232r  --enable-vsllink --enable-xds110   --enable-osbdm  --enable-opendous   --enable-aice   --enable-usbprog   --enable-rlink --enable-armjtagew --enable-cmsis-dap  --enable-kitprog   --enable-usb-blaster    --enable-presto --enable-openjtag --enable-jlink    --enable-parport  --enable-jtag_vpi --enable-amtjtagaccel   --enable-bcm2835gpio  --enable-imx_gpio --enable-ep93xx   --enable-at91rm9200 --enable-gw16012   --enable-minidriver-dummy --enable-remote-bitbang PKG_CONFIG_LIBDIR=/mingw64/lib/pkgconfig
    ```


## Error with aarch32

  1. error found when `load_image xxx.elf 0x10000000 elf` 
      abort occurred -- dscr = 0x0a004353
      Timeout waiting for aarch64_exec_opcode
  2. error found when `resume`
      Timeout waiting for dpm prepare
      Error: Opcode 0x8f00f390, DSCR.ERR=1, DSCR.EL=3

## common commands
  1. openocd & telnet command
     * openocd.exe -f *.cfg
     * telnet 127.0.0.1 4444 -f logfile
     * dap info 
     * poll
     * halt
     * resume
     * reg
     * mdw address len
     * mww address data
  2. arm-none-gdb command
     * arm-none-gdb -f xx.elf
     * set logging file gdb_logfile
     * set logging on
     * target remote 127.0.0.1:8080
     * monitor reset halt
     * load
     * info reg
     * info br
     * disassem 
     * si
     * next

## [gdb refcard](https://users.ece.utexas.edu/~adnan/gdb-refcard.pdf)

## A53 JTAG debug 

* A53 and A32 should use *aarch64-elf-gdb*. The *arm-none-eabi-gdb* will report got a long package error as below

> Remote 'g' packet reply is too long (expected 168 bytes, got 788 bytes): 00000000000000004001000000000000030000000000000000100ca000000000001000a000000000000000100000000000000000000000000010000000000000bf27000000000000f027000000000000000000000000000000000000000000000000000000000000f8ff02100000000000180ca0000000000000000000000000000000000000000000f00210000000000000000000000000000003100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aaaaaaaa00000000dc440010000000001f00006000000000000000000000f03f01e0e1ff0000000000000000e1e1e1ff000000000000000000000000000000000000000000000000000000000000f03f0000000000000000000000000060664000000000000000000000000000000000000000000000000000000000e1e1e1ffe1e1e1ff000000000000000000000000940200000000000000000000000000009402000000000000000000000000f03fe4e1e1ff00000000000000000000000000000000000000000000000000000000d01d3303000000000000000000000000d0994c5300000000000000000000000010ba4e53000000000000000000000000d0124e530000000000000000000000001d00001d00000000aaaaaaaa000000006088330300000000aaaaaaaa000000000000000000000000aaaaaaaa000000000000000000000000aaaaaaaa000000000000000000000000aaaaaaaa000000000100000000000000aaaaaaaa00000000000000ff00000000aaaaaaaa000000000000000000000000aaaaaaaa000000000000000000000000aaaaaaaa000000000000000000000000aaaaaaaa000000001600000000000000aaaaaaaa00000000c100000000000000aaaaaaaa00000000c0bf370300000000aaaaaaaa000000000000000000000000aaaaaaaa000000000000000000000000aaaaaaaa000000000000000000000000aaaaaaaa0000f03f00000000043d0810043d0810

* JLink hardware version should be above **V10**

  
