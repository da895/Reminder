## [GNU make from mad-scientist](http://make.mad-scientist.net/papers/) 

## [modern-cmake tutorial](https://cliutils.gitlab.io/modern-cmake/README.html)

## [cMake](./cmake.md)

## [cmake-example](https://github.com/ttroy50/cmake-examples)

*  [cmake with static and dynamic lib](https://github.com/atrelinski/CMake-Example)
* [Use CMake to Create and Use Dynamic Libraries](https://batuhankoc.medium.com/use-cmake-to-create-and-use-dynamic-libraries-5f6498417b3c)
*  [dll linking](https://discourse.cmake.org/t/dll-linking/4805)
* [An Introduction to Modern CMake](https://cliutils.gitlab.io/modern-cmake/README.html)
* [cmake-examples](https://github.com/ttroy50/cmake-examples)
* [What is a CMake generator?](https://stackoverflow.com/questions/25941536/what-is-a-cmake-generator)
* [cmake find_package 原理简介以及使用说明](https://blog.csdn.net/chengde6896383/article/details/86497016)
* [mraa](https://github.com/eclipse/mraa)

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
