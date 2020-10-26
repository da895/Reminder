
The differences between Linux shells (namely BASH and TCSH) 
===========================================================

<!-- vim-markdown-toc GFM -->

* [The differences between Linux shells (namely BASH and TCSH)](#the-differences-between-linux-shells-namely-bash-andtcsh)
* [Overview](#overview)
  * [C shell -- *CSH*/*TCSH*](#c-shell----cshtcsh)
  * [Bourne again shell -- *BASH*](#bourne-again-shell----bash)
* [Interactive features of *CSH* and *BASH*](#interactive-features-of-csh-and-bash)
  * [*CSH*](#csh)
  * [*BASH*](#bash)
* [Variables](#variables)
  * [Shell Variables](#shell-variables)
    * [*BASH*](#bash-1)
    * [*CSH*](#csh-1)
  * [Referencing Undefined Variables](#referencing-undefined-variables)
    * [*BASH*](#bash-2)
    * [*CSH*](#csh-2)
  * [Environment Variables](#environment-variables)
    * [*BASH*](#bash-3)
    * [*CSH*](#csh-3)
  * [Per Command Variables](#per-command-variables)
    * [*BASH*](#bash-4)
    * [*CSH*](#csh-4)
  * [Unset a Variable](#unset-a-variable)
    * [*BASH*](#bash-5)
    * [*CSH*](#csh-5)
  * [Variable interpretation](#variable-interpretation)
    * [Both shells will evaluate non-quoted variable expressions](#both-shells-will-evaluate-non-quoted-variable-expressions)
    * [Both shells will [not]{style="text-decoration:underline;"} evaluate single-quoted variable expressions](#both-shells-will-notstyletext-decorationunderline-evaluate-single-quoted-variable-expressions)
    * [Both shells will evaluate double-quoted variable expressions](#both-shells-will-evaluate-double-quoted-variable-expressions)
  * [Syntax checking in *BASH*](#syntax-checking-inbash)
  * [Startup scripts](#startup-scripts)
    * [BASH](#bash-6)
      * [Login](#login)
      * [Opening a shell](#opening-a-shell)
      * [Running a script](#running-a-script)
    * [CSH](#csh-6)
      * [Login](#login-1)
      * [Opening a shell](#opening-a-shell-1)
      * [Running a script](#running-a-script-1)
  * [Prevent loading the .cshrc file](#prevent-loading-the-cshrc-file)
  * [Prevent loading the .bashrc and .bash_profile files](#prevent-loading-the-bashrc-and-bash_profile-files)
  * [Running with a clean environment](#running-with-a-clean-environment)
    * [BASH](#bash-7)
    * [CSH](#csh-7)
  * [PATH and path](#path-and-path)
  * [Redirects catching just STDERR, STDOUT, or both](#redirects-catching-just-stderr-stdout-or-both)
    * [*BASH*](#bash-8)
    * [*CSH*](#csh-8)

<!-- vim-markdown-toc -->


Overview
========

The two most common shells in Linux are *CSH* and *BASH*. Shells are
programs used to allow a user to enter and execute commands as well as
to interpret entire files of commands called scripts. You can work with
Graphical User Interfaces (GUIs) in Linux but the real power of Linux is
that it was designed around Command Line Interfaces (CLIs) and thus you
realize significant benefits when working with CLIs from a shell.

> I would recommend you pick *one of these* shells and learn it, and
> that you learn it well.

The Korn shell (KSH) is another fairly popular shell which extends from
the Bourne shell (sh), just as *BASH* does, but I won't spend a lot of
time talking about *KSH* here.  It is worth learning a little about
*KSH*, you may like the fact that it has backward compatibility with
*sh* and it has an interactive style similar to *CSH*.

C shell -- *CSH*/*TCSH*
-----------------------

The C shell shares a lot of the flow control constructs as the C
programming language and thus this shell is dubbed the "C shell". The
Tee-shell, Tee-cee-sheel, or Tee-cee-ess-aitch (TCSH) is really just
*CSH* with command-line completion and other features, most people today
who are using *CSH* are really using *TCSH*, yet only refer to their
shell as *CSH*. For the remained of this post *CSH* will be used but it
will be referring to TCSH as a whole.

Bourne again shell -- *BASH*
----------------------------

The Bourne shell (SH) was the standard shell in older versions of
UNIX (starting with the Seventh Edition). As part of the GNU project,
the Bourne shell was re-implemented to provide interactive features and
this newer version of the Bourne shell is called the Bourne again shell
(BASH). Almost all UNIX based systems today are still delivered with
*SH *or what is really *BASH* emulating *SH*. Of the popular
shells, *BASH*/*SH* is the oldest and most widely used.

Because every UNIX based system is delivered with *BASH* you will
undoubtedly have to use it if you are working on Linux for an extended
period of time.

> Regardless of your preferred shell, I would also recommend you learn
> the basics of *BASH*.

Interactive features of *CSH* and *BASH*
========================================

*CSH*
-----

One benefit of *CSH* is that it has a truly interactive feature not
found in *BASH*. For instance, the following lines are evaluated
interactively (i.e. line-by-line) in *CSH*:

``` {.prettyprint}
> if ( 1 ) then
>  echo true
true
> endif
```

*BASH*
------

While *SH* (Bourne Shell) does not support interactive mode
supposedly *BASH* does. However, this might behave differently than you
would expect, as *BASH* commands are evaluated in logical blocks.

There are some subtle differences between *CSH* and *BASH* interactive
modes. For example, *BASH* will evaluate blocks at the end whereas *CSH*
will evaluate blocks as they are entered. Here is the same example as
provided for *CSH*, but now provided for *BASH*:

``` {.prettyprint}
$ if [ 1 ]; then
>  echo true
> fi
true
```

Both shells behave very similar, with one difference and that is: *BASH*
evaluates in blocks of logic in the interactive mode while *CSH* does
the evaluation line-by-line.

Variables
=========

Shell Variables
---------------

### *BASH*

In *BASH* you can set a shell variable using:

    $ abc=123

*BASH* does not handle spaces very well:

    $ abc = 123
    BASH: abc: command not found

When we say a shell variable we mean that child processes will not
inherit the variable.  This enables you to set variables and work with
them locally, and to be sure that what you did won't have some perverse
effect on child processes that you start.

To demonstrate what a shell variable means, let's create a *run.sh*
script:

``` {.brush: .bash; .light: .true; .title: .run.sh; .notranslate title="run.sh"}
#!/bin/bash
echo switch:$switch
```

To execute this script, we would use (make sure it has executable
permissions \[chmod +x ./run.sh\]):

    $ ./run.sh
    switch:

From here you will see that nothing is printed for the *switch*
variable.

### *CSH*

In C*SH* you can set a shell variable using:

    > set abc=123

*CSH* trims spaces:

    > set abc =   123
    > echo "'${abc}'"
    '123'

Let's create a script to demonstrate some of the use cases.  Let's call
it *run.csh*:

``` {.brush: .bash; .light: .true; .title: .run.csh; .notranslate title="run.csh"}
#!/bin/csh
echo switch:$switch
```

To invoke this script, we would use (make sure it has executable
permissions \[chmod +x ./run.csh\]):

    > ./run.csh
    switch: Undefined variable.

As you can see, for *CSH* an unset variable is an error condition.

Referencing Undefined Variables
-------------------------------

### *BASH*

Unset variables in *BASH* are allowed by default.  Just as you saw above
with the run.csh script this is an error condition for CSH. Earlier we
ran the run.sh script and that didn't error even though it had very
similar code. Here is that example again:

    $ ./run.sh 
    switch:

We can actually force *BASH* to report an error for undefined
variables.  This is done using *BASH* set variables, and to make our
scripts behave the same way we would do this:

``` {.brush: .bash; .light: .true; .title: .run.sh; .notranslate title="run.sh"}
#!/bin/bash
set -u
echo switch:$switch
```

Running this script again will produce an error now:

    $ ./run.sh 
    ./run.sh: line 3: switch: unbound variable

### *CSH*

As we already pointed out *CSH* will error, by default, if an undefined
variable is referenced. Here is that example provided again:

    > ./run.csh
    switch: Undefined variable.

Environment Variables
---------------------

### *BASH*

From here you can run *export* to make this variable accessible to the
child processes:

    $ switch=on
    $ export switch
    $ ./run.sh
    switch:on

    $ echo test:$switch
    test:on

You can simplify this by declaring, defining, and exporting the variable
all in the same line:

    $ export switch=off
    $ ./run.sh 
    switch:off

### *CSH*

In *CSH* we use the *setenv* command to make environment variables
visible to child processes. Here is an example of that syntax:

    > setenv switch=on
    > ./run.csh
    switch:on

    > echo test:$switch
    test:on

Per Command Variables
---------------------

### *BASH*

With *BASH* we can actually set this variable on a per command line
basis:

    $ switch=on ./run.sh
    switch:on

    $ echo test:$switch
    test:

Setting a variable on the same line as a command, in *BASH,* will affect
the child process. However, the local shell or script will not be
impacted (as shown above with 'test:').

Furthermore, we can also run this on multiple lines and see different
results than when set on the same line as a command:

    $ switch=on
    $ ./run.sh
    switch:

    $ echo test:$switch
    test:on

In the script you can see that the variable shows as unset, even though
in the parent shell we have set it. This is what is meant by a shell
variable.

### *CSH*

C*SH* doesn't have as convenient of a way as *BASH* does for setting
a variable on a per command line basis, but you can still do this using
the concept of subshells:

    > (setenv switch on; ./run.csh)
    switch:on

    > echo test:$switch
    test:

Setting a variable in a subshell will not impact the parent shell or
script.

However, we can also run this on multiple lines with different results:

    > switch=on
    > ./run.sh
    switch:

    > echo test:$switch
    test:on

In the script you can see that the variable shows as unset, even though
in the parent shell we have set it. This is what is meant by a 'local'
variable.

Unset a Variable
----------------

### *BASH*

Once a variable is set you can unset and unexport it with the *unset*
command:

    $ export switch=off
    $ unset switch
    $ ./run.sh 
    switch:

Even if you set the variable again, it is no longer exported after an
unset:

    $ export switch=off
    $ unset switch
    $ switch=on
    $ ./run.sh 
    switch:

However, it is important to note that once a variable is exported
changes to it's value will impact new child processes:

    $ export switch=off
    $ ./run.sh 
    switch:off
    $ switch=on
    $ ./run.sh 
    switch:on

### *CSH*

Before we talk about how to unset a variable in *CSH* we should talk
about how variables are managed in *CSH*. The shell variables and the
environment variables are handled in completely different ways and these
different mechanisms can be said to be independent of each-other.
Furthermore, it is only the referencing of these variables that is the
same.

What is meant by independent mechanisms? The shell variables can be set
and unset independent of environment variables. Once a variable is set
you can unset it with the unset or unsetenv command.  Here's an example:

    > setenv switch on
    > echo envvar:$switch
    envvar:on
    > set switch=off
    > echo shell:$switch
    shell:off
    > unset switch
    > echo envvar:$switch
    envvar:on
    > unsetenv switch
    > echo $switch
    switch: Undefined variable.

appending \$(path 123)

direct access

Variable interpretation
-----------------------

### Both shells will evaluate non-quoted variable expressions

Here is an example in *CSH*:

``` {.prettyprint}
> set test = "value"
> echo $test
value
```

Here is an equivalent example is *BASH*:

``` {.prettyprint}
$ test="value"
$ echo $test
value
```

### Both shells will [not]{style="text-decoration:underline;"} evaluate single-quoted variable expressions

Here is an example in *CSH*:

``` {.prettyprint}
> set test = "value"
> echo '$test'
$test
```

Here is an equivalent example is *BASH*:

``` {.prettyprint}
$ test="value"
$ echo '$test'
$test
```

### Both shells will evaluate double-quoted variable expressions

Here is an example in *CSH*:

``` {.prettyprint}
> set test = "value"
> echo "$test"
value
```

Here is an equivalent example is *BASH*:

``` {.prettyprint}
$ test="value"
$ echo "$test"
value
```

Things start to differ when escaping the dollar sign (\$) in a double
quotes use case. Here is an example script, *test.sh,* script showing
how to escape variable evaluation in *BASH*:

``` {.brush: .bash; .light: .true; .title: .test.sh; .notranslate title="test.sh"}
#!/bin/bash
#test
check="test"
grep "${check}$" $0
```

This script should search (using *grep*) this file (*\$0* is this file)
for lines that end with "test" (in regex *\$* signifies the
end-of-line), and this does work as expected. Running this script finds
the '\#test' line as expected:

``` {.prettyprint}
$ ./test.sh
#test
```

However, there are some nuances with *CSH*. For example, this script
(*test.csh*), looks like it should work:

``` {.brush: .bash; .light: .true; .title: .test.csh; .notranslate title="test.csh"}
#!/bin/csh
#test
set check = "test"
grep "${check}$" $0
```

This actually produces an error:

``` {.prettyprint}
> ./test.csh
Variable name must contain alphanumeric characters.
```

In *CSH* this should actually be executed as (quotes are removed from
*grep*):

``` {.brush: .bash; .light: .true; .title: .test.csh; .notranslate title="test.csh"}
#!/bin/csh
#test
set check = "test"
grep ${check}$ $0
```

This will work as expected:

``` {.prettyprint}
> ./test.csh
#test
```

It is nearly impossible to escape a dollar sign (\$) inside of double
quotes when using *CSH*; However, single quotes will prevent expansion,
or just using variables without quotes enables escape sequences to solve
the problem.

Syntax checking in *BASH*
-------------------------

Syntax can be checked in *BASH* with:

``` {.prettyprint}
bash -n script.sh
```

This syntax checking process is nice as it does not execute any of the
commands, and just checks the entire script for syntax.  This is a quick
and easy way to validate all logical branches in a script, for syntax.
If you forget to add a semicolon after a square bracket in an if
statement, such as this *test.sh* file:

``` {.brush: .bash; .light: .true; .title: .test.sh; .notranslate title="test.sh"}
#/bin/bash
one=1
if [ $one ] then
  echo test
fi
```

Then the following syntax error will be reported:

    ./test.sh: line 5: syntax error near unexpected token `fi'
    ./test.sh: line 5: `fi'

However, a simple syntax error such as adding spaces around the equal
sign in a variable assignment will not be caught:

``` {.brush: .bash; .light: .true; .title: .test.sh; .notranslate title="test.sh"}
#/bin/bash
one = 1
if [ $one ]; then
  echo test
fi
```

This is because the syntax checker doesn't considered this a syntax
error. The *BASH* syntax checker will think that *one* is a command.
 This script will error at run-time with the following error:

    ./test.sh: line 2: one: command not found

Bottom-line: The syntax checker in *BASH* is nice and should be used to
check syntax of *BASH* scripts, but be aware that the syntax checker
will not catch everything.  Unfortunately, *CSH* doesn't have an
equivalent.

Startup scripts
---------------

### BASH

The following scripts are used in BASH...

#### Login

-   /etc/profile (system)
-   /etc/bash.bashrc (system)
-   \~/.bash_profile
-   \~/.bash_login
-   \~/.profile
-   \~/.bashrc

#### Opening a shell

-   \~/.bashrc

#### Running a script

-   /etc/bash.bashrc (system)

### CSH

The following scripts are used in CSH...

#### Login

-   /etc/CSH.cshrc (system)
-   /etc/CSH.login (system)
-   \~/.tcshrc
-   \~/.cshrc
-   \~/.history
-   \~/.login
-   \~/.cshdirs

#### Opening a shell

-   /etc/CSH.cshrc (system)
-   \~/.tcshrc
-   \~/.cshrc

#### Running a script

-   \~/.cshrc

Prevent loading the .cshrc file
-------------------------------

The .cshrc file is a file where you can specify *CSH *commands to be
executed every-time you load *CSH*. However, sometimes you want default
*CSH* (i.e. that does not have your custom commands run) and this can be
done with the -f switch.  This can, and should, be set in all *CSH*
scripts as it helps to ensure that you are not depending on settings in
your current environment:

``` {.brush: .bash; .light: .true; .title: .path.csh; .notranslate title="path.csh"}
#!/bin/csh -f
env
```

This script will show you what your environment variables looks like
without your *.cshrc* file being sourced. You can also use the -f switch
when opening a new shell:

``` {.brush: .bash; .light: .true; .title: .csh; .notranslate title="csh"}
> csh -f
```

Prevent loading the .bashrc and .bash_profile files
---------------------------------------------------

The .bashrc and .bash_profile files are places where you can specify
custom commands to be executed every-time you start a *BASH* shell or
login, respectively. However, sometimes you want default *BASH* (i.e.
that does not have your custom commands run) and this can be done with
the --norc and --noprofile switches.  These arguments can only be
specified on the command line:

``` {.brush: .bash; .light: .true; .title: .csh; .notranslate title="csh"}
$ bash --norc --noprofile
```

Running with a clean environment
--------------------------------

Have you ever been stuck seeing strange behavior that nobody else on
your project is seeing? Have a sneaking suspicion that your environment
is messed up? In swoops the 'env' command to save the day!

Running with 'env -i \<command\>' will prevent your environment
variables from being inherited from child processes. When used in
conjunction with switches to prevent shell scripts from running, you can
be pretty confident that you have a clean environment.

### BASH

To run clean:

``` {.brush: .bash; .light: .true; .title: .bash; .notranslate title="bash"}
$ env -i bash --norc --noprofile
```

### CSH

To run clean:

``` {.brush: .bash; .light: .true; .title: .csh; .notranslate title="csh"}
> env -i csh -f
```

PATH and path
-------------

Both *BASH *and *CSH *shells have and use the \$PATH environment
variable. However, *CSH *has a variable called \$path which can be
manipulated in a slightly different way. Generally the use case of the
PATH environment variable is so that applications can find executables
and this is done by adding executable directories to the PATH
environment variable. *CSH* gives us a direct and convenient way to do
this:

``` {.prettyprint}
set path = ($path /usr/local/bin)
```

The lower case path variable enables direct access indexes:

``` {.prettyprint}
> echo $path[1]
/home/pi/bin
```

Redirects catching just STDERR, STDOUT, or both
-----------------------------------------------

### *BASH*

Let's start with a script that prints a message to both STDERR and
STDOUT:

``` {.brush: .bash; .light: .true; .title: .std.sh; .notranslate title="std.sh"}
#!/bin/bash
echo "message intended for stdout"
(&amp;amp;amp;amp;amp;amp;gt;&amp;amp;amp;amp;amp;amp;amp;2 echo "message intended for stderr")
```

Now if we call this script this is what we'll see:

    $ ./std.sh 
    message intended for stdout
    message intended for stderr

In *BASH* to redirect STDOUT only:

    $ ./std.sh > out.log
    message intended for stderr
    $ cat out.log
    message intended for stdout

In *BASH* to redirect STDERR only:

    $ ./std.sh 2> err.log
    message intended for stdout
    $ cat err.log
    message intended for stderr

In *BASH* to redirect both:

    $ ./std.sh >& std.log
    $ cat std.log
    message intended for stdout
    message intended for stderr

In *BASH* to redirect STDOUT to one file and STDERR to another:

    $ ( ./std.sh 2> err.log ) > out.log
    $ cat err.log
    message intended for stderr
    $ cat out.log
    message intended for stdout

### *CSH*

We will use the same script provided above *(BASH)* that prints a
message to both STDERR and STDOUT, but we will invoke this script from
*CSH* and manipulate the STDERR and STDOUT streams:

``` {.brush: .bash; .light: .true; .title: .std.sh; .notranslate title="std.sh"}
#!/bin/csh
echo "message intended for stdout"
(>&2 echo "message intended for stderr")
```

Now if we call this script this is what we'll see (remember we are in
*CSH*):

    > ./std.sh
    message intended for stdout
    message intended for stderr

In C*SH* to redirect STDOUT only:

    > ./std.sh > out.log
    message intended for stderr
    > cat out.log
    message intended for stdout

In C*SH* to redirect STDERR only:

    $ ( ./std.sh > /dev/tty ) > & err.log
    message intended for stdout
    $ cat err.log
    message intended for stderr

In C*SH* to redirect both:

    $ ./std.sh > & std.log
    $ cat std.log
    message intended for stdout
    message intended for stderr

In C*SH* to redirect STDOUT to one file and STDERR to another:

    $ ( ./std.sh > out.log ) > & err.log
    $ cat err.log
    message intended for stderr
    $ cat out.log
    message intended for stdout
