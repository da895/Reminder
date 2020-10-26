# Makefile


<!-- vim-markdown-toc GitLab -->

* [Recursive make in subdirectories](#recursive-make-in-subdirectories)
* [CFLAGS of -MD, -MMD or -MT](#cflags-of-md-mmd-or-mt)
* [Options controlling the preprocessor for GCC](#options-controlling-the-preprocessor-for-gcc)
* [Properly using GNU-Make](#properly-using-gnu-make)
* [GNU make](#gnu-make)
* [makfile tutorial](#makfile-tutorial)
* [Is there a logical OR operator for the 'ifneq'](#is-there-a-logical-or-operator-for-the-ifneq)
* [Makefile variable is empty](#makefile-variable-is-empty)
* [makefile cheatsheet](#makefile-cheatsheet)
* [ isaacs/Makefile ](#-isaacsmakefile-)

<!-- vim-markdown-toc -->

## Recursive make in subdirectories
    
    * Read [Recursive Use of Make](http://www.gnu.org/software/make/manual/make.html#Recursion)chapter of GNU Make
    * Learn Peter Miller's [Recursive Make Considered Harmful](./Recursive_Make_Considered_harmful.pdf)

##  [CFLAGS of -MD, -MMD or -MT](https://news.ycombinator.com/item?id=15061255)

    -MT "$@ $(basename $@).d"

## [Options controlling the preprocessor for GCC](https://gcc.gnu.org/onlinedocs/gcc/Preprocessor-Options.html)

    -D name 
        Predefine name as a macro, with definition 1.

    -D name=definition

    -U name
        Cancel any previous definition of name, either built in or provided with a -D option

    -M 
        Generate the information associated with the file. Contains all source code that target file depends on.

    -MM 
        It;s the same as -M, but it ignores the dependencies caused by #include

    -MMD
        The same as -MM, but it output will be imported intop the .d file.

    -MD 
        similar to -MMD, the content exported is different, the content is the same as -M.

    -MF file
        when used with -M or -MM, specifies a file to write the dependencies to.
        when used with -MD or -MMD, -MF overrides the default dependency output file

    -MP
        This option instructs CPP to add a phony target for each dependency other than the main file, causing each to depend on nothing. These dummy rules work around errors make gives if you remove header file without updating the Makefile to match

    -MG
        This feature is used in automatic updating of makefile

    -MT target
        An -MT option sets the target to be exactly the string you specify.
        For example, -MT '$(objpfx)foo.o' might give 
        `$(objpfx)foo.o: foo.c`

## [Properly using GNU-Make](https://slashvar.github.io/2017/02/13/using-gnu-make.html)

## [GNU make](https://www.gnu.org/software/make/manual/make.html)

## [makfile tutorial](https://makefiletutorial.com/)

## Is there a logical OR operator for the 'ifneq'

https://stackoverflow.com/questions/8296723/is-there-a-logical-or-operator-for-the-ifneq
```makefile
ifeq ($(filter y,$(WNDAP660) $(WNADAP620)),)
...
endif
```


https://stackoverflow.com/questions/6015343/conditional-or-in-makefile/13410692
```makefile
ifneq "$(or $(LINUX_TARGET),$(OSX_TARGET))" ""

endif
```
Similar to the **$(strip** approach, but using the more intuitive **$(or** keyword 

## [Makefile variable is empty](https://stackoverflow.com/questions/38801796/makefile-set-if-variable-is-empty)

```makefile
ifeq ($(origin VARNAME),undefined)
VARNAME := "now it's finally defined"
endif
```

```makefile
ifeq ($(strip $(foo)),)
text-if-empty
endif
```

## [makefile cheatsheet](https://devhints.io/makefile)

## [ isaacs/Makefile ](https://gist.github.com/isaacs/62a2d1825d04437c6f08)

    should add `SHELL=bash` at first line
