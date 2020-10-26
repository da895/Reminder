# UVM and SV minutes

## [corev-verfi-environment](https://github.com/openhwgroup/core-v-verif/tree/master/mk#required-corev-environment-variables)

## [Gate level model](https://vlsiverify.com/verilog/gate-level-modeling/)

## [dsim install](https://help.metrics.ca/support/solutions/articles/154000141162-install-dsim-desktop)

## [UVM 1.2 Class Reference](https://verificationacademy.com/verification-methodology-reference/uvm/docs_1.2/html/index.html)

## [Using SystemVerilog Assertions in RTL Code](https://www.design-reuse.com/articles/10907/using-systemverilog-assertions-in-rtl-code.html)

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

## debug UVM by verdi online

```
-gui
-kdb
+UVM_VERDI_TRACE="AWARE+HIER+RAL+TLM+IMP"
```
## [UVM Modelsim compile problem: Could not link 'vsim_auto_compile.so'](https://github.com/lowRISC/ibex/issues/503)

     1. Add '-dpicpppath /usr/bin/gcc' to vsim option.  I hope this helps.
     2. the modelsim.ini variable "DpiCppPath" to vlog and qverilog.
