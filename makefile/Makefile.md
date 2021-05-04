# Makefile

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
