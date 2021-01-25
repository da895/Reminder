# Shell -- tcsh, bash, etc

<!-- vim-markdown-toc GFM -->

* [TCSH](#tcsh)
* [**Differences between BASH and TCSH**](#differences-between-bash-and-tcsh)

<!-- vim-markdown-toc -->

## [TCSH](https://www.tcsh.org)

1. [An Introduction to the C Shell](./csh-intro.pdf)
2. [tcsh Manual Pages](./tcsh.pdf)
3. [tcsh wiki](https://en.wikibooks.org/wiki/C_Shell_Scripting)

## **Differences between BASH and TCSH**

1. [Some differences between BASH and TCSH](https://web.fe.up.pt/~jmcruz/etc/unix/sh-vs-csh.html)
2. [The differences between Linux shells (namely BASH and TCSH)](https://thesoftwareprogrammer.com/2017/11/15/the-differences-between-linux-shells-namely-bash-and-tcsh/)
3. [Comparison with Bourne shell](https://en.wikibooks.org/wiki/C_Shell_Scripting/syntax#Comparison_with_Bourne_shell)
   * Features
     a. List variables
        C shell has it Bourne doesn't
     b. Shell functions
        Bourne has it C shell doesn't
   * Syntax differences
     a. comments
     ```
     # csh
     : sh
     ```
     b. assigning variables
     ```
     set a = b
     a=b
     ```
     c. expressions
     ```
     if ( a < b ) then
     else if () then
     else
     endif

     if [ a -lt b ] ; then
     elif [] ; then
     else
     fi
     ```
     d. command substitution
     ```
     `date`

     $( date )
     ```
     [Bourne Shell Scripting/Substitution](https://en.wikibooks.org/wiki/Bourne_Shell_Scripting/Variable_Expansion)
