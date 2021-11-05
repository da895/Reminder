
## Array

1. `declare -a array`   -- Declare an array
2. `array+=(sth)`       -- append sth into array
3. `${array[@]}`        -- get all elements in array
4. `${!array[@]}`       -- get the list of all array indices(begin with 0)
5. `${#array[@]}`       -- get the array length
6. `array[3]=sth`       -- overwrite fourth element
7. `${array[@]:s:n}`    -- get n elements starting at index s

## Variable

-  $0 - The name of the Bash script.
-  $1 - $9 - The first 9 arguments to the Bash script.
-  $# - How many arguments were passed to the Bash script.
-  $@ - All the arguments supplied to the Bash script.
-  $? - The exit status of the most recently run process.
-  $$ - The process ID of the current script.
-  $USER - The username of the user running the script.
-  $HOSTNAME - The hostname of the machine the script is running on.
-  $SECONDS - The number of seconds since the script was started.
-  $RANDOM - Returns a different random number each time is it referred to.
-  $LINENO - Returns the current line number in the Bash script.
-  $FUNCNAME - Returns the function name

## User input

- simple menu

```bash
 #!/bin/bash
 OPTIONS="Hello Quit"
 select opt in $OPTIONS; do
     if [ "$opt" = "Quit" ]; then
      echo done
      exit
     elif [ "$opt" = "Hello" ]; then
      echo Hello World
     else
      clear
      echo bad option
     fi
 done
```

- command line

```bash
#!/bin/bash        
if [ -z "$1" ]; then 
    echo usage: $0 directory
    exit
fi
SRCD=$1
TGTD="/var/backups/"
OF=home-$(date +%Y%m%d).tgz
tar -cZf $TGTD$OF $SRCD
```

- read user input

```bash
#!/bin/bash
echo Please, enter your firstname and lastname
read FN LN 
echo "Hi! $LN, $FN !"
```

## Arithmetic 

- `echo $((1+1))`
- `echo 3/4 | bc -l`

```bash
ifndef_any_of = $(filter undefined,$(foreach v,$(1),$(origin $(v))))
ifdef_any_of = $(filter-out undefined,$(foreach v,$(1),$(origin $(v))))

ifneq ($(call ifdef_any_of,VAR1 VAR2),)
ifeq ($(call ifndef_any_of,VAR1 VAR2),)
```

## [Remove item from a Makefile variable](https://stackoverflow.com/questions/7402205/remove-item-from-a-makefile-variable)

```bash
THERVAR := $(filter-out SomethingElse,$(VAR))

```

