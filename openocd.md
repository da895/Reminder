
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
