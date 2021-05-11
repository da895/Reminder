* [TCL doc](https://www.tcl.tk/doc/)

* [Modern Tk Best Practices](https://tkdocs.com/)

* [tcl-lang](https://wiki.tcl-lang.org/page/grep)

* common command
  * lsearch
  * regexp
  * regsub

* grep within TCL
  * using `lsearch`
```tcl
# Read in all the lines
set f [open $file_path/file]
set lines [split [read $f] \n]
close $f

# Filter the lines
set matches [lsearch -all -inline -glob $lines *test*]

# Write out the filtered lines
set f [open $file_path/des_file w]
puts $f [join $matches \n]
close $f
```
  * using `regexp`
```tcl
proc grep {re {f stdin}} {
    for {set i 0} {[gets $f line] >= 0} {incr i} {
        if {[regexp $re $line]} {
            puts "$i:$line" 
        }
    }
}
```
  * using system call
```tcl
set shell_script "cat $file_path/file |grep test > $file_path/des_file"
exec sh -c $shell_script
```
```tcl
exec /bin/sed {s/ +/ /g} $file
```
```tcl
exec /bin/sh -c "sed 's/ +/ /g' $file"
```
```tcl
set f [open $file]
set replacedContents [regsub -all { +} [read $f] " "]
close $f
```
