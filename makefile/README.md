## [GNU make from mad-scientist](http://make.mad-scientist.net/papers/) 

## [modern-cmake tutorial](https://cliutils.gitlab.io/modern-cmake/README.html)

## [cMake](./cmake.md)

## [cmake-example](https://github.com/ttroy50/cmake-examples)

## [cmake static/dynamic lib](https://github.com/atrelinski/CMake-Example)

## [How to make a binary file length multiple of 16byte](https://community.st.com/s/question/0D53W000006FsdgSAC/how-to-make-a-binary-file-length-multiple-of-16byte)

Normally the solution is to add a small part to the binary at the end to align the entire binary file to 16B.

Here is an example from a UserApp linker script:
```
  /* Extra ROM section (last one) to make sure the binary size is a multiple of the AES block size (16 bytes) and F7 flash writing unit (4 bytes)*/
  .align16 :
  {
    . = . + 1;         /* _edata=. is aligned on 8 bytes so could be aligned on 16 bytes: add 1 byte gap */
    . = ALIGN(16) - 1; /* increment the location counter until next 16 bytes aligned address (-1 byte)   */
    BYTE(0);           /* allocate 1 byte (value is 0) to be a multiple of 16 bytes                      */
  } > APPLI_region_ROM
```
