# UVM and SV minutes

## [UVM 1.2 Class Reference](https://verificationacademy.com/verification-methodology-reference/uvm/docs_1.2/html/index.html)

## [Using SystemVerilog Assertions in RTL Code](https://www.design-reuse.com/articles/10907/using-systemverilog-assertions-in-rtl-code.html)

## debug UVM by verdi online

```
-gui
-kdb
+UVM_VERDI_TRACE="AWARE+HIER+RAL+TLM+IMP"
```
## [UVM Modelsim compile problem: Could not link 'vsim_auto_compile.so'](https://github.com/lowRISC/ibex/issues/503)

     1. Add '-dpicpppath /usr/bin/gcc' to vsim option.  I hope this helps.
     2. the modelsim.ini variable "DpiCppPath" to vlog and qverilog.
