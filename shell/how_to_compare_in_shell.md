How to Compare Numbers and Strings in Linux Shell Script 
========================================================


In this tutorial on Linux bash shell scripting, we are going to learn
how to compare numbers, strings and files in shell script using if
statement. Comparisons in a script are very useful & after comparison
result, script will execute the commands and we must know how we can use
them to our advantage.

Syntax of comparisons in shell script

    if [ conditions/comparisons]
        then
             commands
    fi

An example


    if [2 -gt 3]
         then
         print "2 is greater"
         else
         print "2 is not greater"
    fi

This was just a simple example of numeric comparison & we can use more
complex statement or conditions in our scripts. Now let’s learn numeric
comparisons in bit more detail.

#### Compare Numbers in Linux Shell Script

This is one the most common evaluation method i.e. comparing two or more
numbers. We will now create a script for doing numeric comparison, but
before we do that we need to know the parameters that are used to
compare numerical values . Below mentioned is the list of parameters
used for numeric comparisons

-   **num1 -eq num2**         check if 1st  number is equal to 2nd number
-   **num1 -ge num2**         checks if 1st  number  is greater than or equal to 2nd number
-   **num1 -gt num2**         checks if 1st  number is greater than 2nd number
-   **num1 -le num2**         checks if 1st number is less than or equal to 2nd number
-   **num1 -lt num2**         checks if 1st  number  is less than 2nd number
-   **num1 -ne num2**         checks if 1st  number  is not equal to 2nd number

Now that we know all the parameters that are used for numeric
comparisons, let’s use these in a script,

    #!/bin/bash
    # Script to do numeric comparisons
    var1=10
    var2=20
    if [ $var2 -gt $var1 ]
        then
            echo "$var2 is greater than $var1"
    fi
    # Second comparison
    If [ $var1 -gt 30]
        then
            echo "$var is greater than 30"
        else
            echo "$var1 is less than 30"
    fi

This is the process to do numeric comparison, now let’s move onto string
comparisons.

#### Compare Strings in Linux Shell Script

When creating a bash script, we might also be required to compare two or
more strings & comparing strings can be a little tricky. For doing
strings comparisons, parameters used are

-   var1 = var2        checks if var1 is the same as string var2
-   var1 != var2       checks if var1 is not the same as var2
-   var1 &lt; var2     checks if var1 is less than var2
-   var1 &gt; var2     checks if var1 is greater than var2
-   -n var1            checks if var1 has a length greater than zero
-   -z var1            checks if var1 has a length of zero

**Note** :-  You might have noticed that greater than symbol (&gt;) &
less than symbol (&lt;) used here are also used for redirection for
**stdin** or **stdout** in Linux. This can be a problem when these
symbols are used in our scripts, so what can be done to address this
issue.

Solution is simple , when using any of these symbols in scripts, they
should be used with escape character i.e. use it as “/&gt;” or “/&lt;“.

Now let’s create a script doing the string comparisons.

In the script, we will firstly be checking string equality, this script
will check if username & our defined variables are same and will provide
an output based on that. Secondly, we will do greater than or less than
comparison. In these cases, last alphabet i.e. z will be highest &
alphabet a will be lowest when compared. And capital letters will be
considered less than a small letter.

    #!/bin/bash
    # Script to do string equality comparison
    name=linuxtechi
    if [ $USER = $name ]
            then
                    echo "User exists"
            else
                    echo "User not found"
    fi
    # script to check string comparisons
    var1=a
    var2=z
    var3=Z
    if [ $var1 \> $var2 ]
            then
                    echo "$var1 is greater"
            else
                    echo "$var2 is greater"
    fi
    # Lower case  & upper case comparisons
    if [ $var3 \> $var1 ]
            then
                    echo "$var3 is greater"
            else
                    echo "$var1 is greater"
    fi

We will now be creating another script that will use “**-n**” & “**-z**”
with strings to check if they hold any value

    #!/bin/bash
    # Script to see if the variable holds value or not
    var1=" "
    var2=linuxtechi
    if [ -n $var1 ]
            then
                    echo "string  is not empty"
            else
                    echo "string provided is empty"
    fi

Here we only used ‘-n’ parameter but we can also use “**-z**“. The only
difference is that with ‘-z’, it searches for string with zero length
while “-n” parameter searches for value that is greater than zero.

#### File comparison in Linux Shell Script

This might be the most important function of comparison & is probably
the most used than any other comparison. The Parameters that are used
for file comparison are

-   -d file                  checks if the file exists and is it’s a directory
-   -e file                  checks if the file exists on system
-   -w file                  checks if the file exists on system and if it is writable
-   -r file                  checks if the file exists on system and it is readable
-   -s file                  checks if the file exists on system and it is not empty
-   -f file                  checks if the file exists on system and it is a file
-   -O file                  checks if the file exists on system and if it’s is owned by the current user
-   -G file                  checks if the file exists and the default group is the same as the current user
-   -x file                  checks if the file exists on system and is executable
-   file A -nt file B        checks if file A is newer than file B
-   file A -ot file B        checks if file A is older than file B

Here is a script using the file comparison

    #!/bin/bash
    # Script to check file comparison
    dir=/home/linuxtechi
    if [ -d $dir ]
            then
                    echo "$dir is a directory"
                    cd $dir
                    ls -a
            else
                    echo "$dir is not exist"
    fi

Similarly we can also use other parameters in our scripts to compare
files. This completes our tutorial on how we can use numeric, string and
file comparisons in bash scripts. Remember, best way to learn is to
practice these yourself.

**[Read Also]** : 

[How to Create Hard and Soft (symlink) Links on Linux Systems](https://www.linuxtechi.com/tips-hard-soft-links-linux-unix-systems/) 

