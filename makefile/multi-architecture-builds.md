Multi-Architecture Builds
=========================

August 18th, 2000    (updated June 8th, 2019)


>
> A very common requirement for build systems today is allowing
> compilation of the same code in multiple environments, at the same
> time. That is, given one set of source code, developers want the
> ability to create more than one set of targets from it.
>
> This can be for anything from a debugging vs. an optimized version of
> the code, to building it on two or more different operating systems
> and/or hardware platforms.
>
> As important as this is, it’s not entirely obvious how to get it
> working well using `make`. The first attempts, usually involving
> VPATH, are generally unsuccessful (see [How **Not** to Use
> VPATH](http://make.mad-scientist.net/papers/how-not-to-use-vpath/ "How Not to Use VPATH")
> for more details).
>
> However, it *is* possible to create a readable, useful, and usable
> build environment for multi-architecture builds. Here I describe a
> method for doing this.
>

Table of Contents
=================

1.  [Other Common Methods](#other)
    1.  [Source Copy Method](#sourcecopy)
    2.  [Explicit Path Method](#explicitpath)
    3.  [VPATH Method](#vpath)
2.  [The Advanced VPATH Method](#advanced)
    1.  [Single Target Directory](#single)
        1.  [Standard Makefile Template](#template)
        2.  [The `target.mk` File](#target.mk)
    2.  [Multiple Target Directories](#multiple)
        1.  [Testing for Extra Target Directories](#testingextra)
        2.  [Standard Makefile Template with Multiple
            Targets](#multitemplate)
        3.  [The `target.mk` File with Multiple
            Targets](#multitarget.mk)
    3.  [Sample Implementation](#sample)
3.  [Acknowledgments](#acknowledgments)
4.  [Revision History](#history)

------------------------------------------------------------------------

Other Common Methods
==============================

First we’ll think about some other methods used for multi-architecture
builds, and discuss the pros and cons. Ideally we’d like a method that
combined all the important advantages while avoiding all the
disadvantages.

There are three main approaches to this problem that are most common:
the [**Source Copy**](#sourcecopy) method, the [**Explicit
Path**](#explicitpath) method, and the [**VPATH**](#vpath) method.

Source Copy Method
---------------------------------

This approach is fairly straightforward. At its simplest, it’s merely a
physical copy of the entire source tree for each separate build type you
want to create. Every time you want to build, you copy the sources to a
new directory and build it there with whatever options you require. If
you want to build it differently, copy the source to another directory
and repeat.

The good point about this method is that makefiles are very simple to
write, read, and use. The makefile creates the targets in the same
directory as the sources, which is very easy. There is no need to resort
to VPATH or alternate directories at all. Also, you can run builds such
as “`make foo.o`” and it works correctly.

Unfortunately the downsides are more significant. Suppose you change a
file; you must have some way of propagating those changes to all the
copies of the tree, for testing: managing this so you don’t forget one
and wreck your build or, even worse, introduce odd bugs is quite a
challenge. And of course, multiple versions of the entire source tree
uses quite a bit more disk space. Note to mention the “thumb-twiddling”
time involved while waiting for the tree to copy in the first place.

#### Symbolic Link Farms

There is a flavor of the Source Copy method often used on UNIX called
the symbolic link farm. The X Consortium, for example, uses this flavor.
Here, a program or shell script is used to first create a “shadow”
directory hierarchy: a copy of the directory structure is created, but
no actual files are copied over. Next, instead of copying the source
files themselves, the program or script creates a symbolic link for each
file from the “shadow” hierarchy back to the “true” hierarchy.

The symbolic link farm has the same advantages as the Source Copy, and
it ameliorates the worst of its disadvantages: since all but one of the
files are sym links you don’t have to copy your changes around (but you
do have to be careful to edit the original, or set up your editor to
handle this situation properly–and some can’t). Link farm copies take up
considerably less space and are faster to create (though still not free)
than normal copies.

Nevertheless, symlinks can be annoying to work with; a small example:
you need to remember to use the `-L` option to `ls -l` when you want to
see the size or modification time of the actual file. Also, adding new
directories or files to the source tree can be problematic: you need to
remember to add them to the master copy, and have a way of updating the
links in all your farms.

Explicit Path Method
-------------------------------------

Better (IMO) than the previous one is the Explicit Path method. You
might take a look at the final result in [How **Not** to Use
VPATH](/papers/how-not-to-use-vpath/ "How Not to Use VPATH") for an
example. In this method, you write your makefiles such that every
reference to every target is prefixed with the pathname where it exists.
For multiple architectures, you merely change that pathname (it’s
obviously always stored in a variable!) The pathname can (and probably
should) be calculated internally to your makefiles based on the current
host architecture, or compiler flags, or both.

Often the target directory is a simple subdirectory of the current
directory, but it could also be someplace completely different; this can
allow, for example, building sources that exist on read-only media
without copying them elsewhere first: the sources are left where they
sit, and the targets are put elsewhere, in a writable area. If you write
your makefiles carefully you can easily accommodate both styles by
simply changing a variable value or two.

Obviously since you’re not copying sources anywhere, you avoid all that
hassle of remembering what to update, when.

The problem here is with the makefiles. First, they’re more difficult to
read, write, and modify: every reference to every target must be
prefixed by some variable. This can make for a lot of redundancy in your
makefiles. Following [Paul’s Fourth Rule of
Makefiles](/papers/rules-of-makefiles/#rule4 "Rule #4") can alleviate
this, but it’s still there.

Second, you cannot use simple rebuild commands like “`make foo.o`“; you
must remember to prefix it with the target directory, like
“`make '$(OBJDIR)/foo.o'`“. This can get unwieldy quickly.

The VPATH Method
--------------------------

Eh? VPATH? But didn’t [we
discover](/papers/how-not-to-use-vpath/ "How Not to Use VPATH") that
VPATH wasn’t useful for multi-architecture builds? Well, not quite. [We
decided](/papers/rules-of-makefiles/#rule3 "Rule #3") VPATH wasn’t
useful for locating *targets*; however, it’s extraordinarily handy for
locating *source* files.

So, this method does just that. Like the [source copy
method](#sourcecopy), we write our makefiles to create all targets in
the current working directory. Then, the makefile uses VPATH to locate
the source files for use, so we can write the source filenames normally
and without a path prefix either.

Now all that has to be done is invoke the build from within the *target*
directory and voila! It works. The makefiles are tidy and easy to
understand, without pathnames prefixed everywhere. You can run builds
using the simple “`make foo.o`” syntax. And you’re not required to
expend time or disk space creating multiple copies of the source tree.

The most popular example of this method are the build environments
created with a combination of GNU autoconf and GNU automake. There, the
`configure` script is run from a remote directory and it sets things up
for you in that remote directory without modifying the original sources.
Then you run a VPATH-capable `make`, such as GNU `make`, and it uses
VPATH to locate the source files in the distribution directory, while
writing the target files in the directory where you invoked the build:
the remote directory.

#### But wait a minute…

Unfortunately, there’s a painful thorn on this rosebush. I glossed over
it above, but the phrase “invoke the build from within the *target*
directory” hides a not-insignificant annoyance for most build
environments.

First, you have to `cd` to another directory from the one you’re editing
in to actually invoke the build. But even worse, the makefile for your
build is back in the source directory. So, instead of just typing
“`make`“, you need to run “`make -f SRC/Makefile`” or similar. Ugh.

The GNU autoconf/automake tools avoid this latter issue by putting the
makefile in the target directory (the `configure` script actually
constructs it at configure time from a template contained in the source
directory). Or, you could set up a symbolic link in the target directory
pointing back to the makefile in the source directory. This can work,
but it’s still annoying and doesn’t address the first problem at all.

The Advanced VPATH Method
======================================

What would be really great is if we could combine the best parts of
*all* three of the above methods. And why not? Looking at them again,
the closest thing to what we really want is the [VPATH method](#vpath).
It’s almost perfect. What does it need to make it just what we want?
Well, we need to avoid having to change directories. So, what the
advanced VPATH method describes is a way of convincing `make` itself to
change directories *for* you, rather than requiring you to do it
yourself.

The algorithm is simple: when `make` is invoked it checks the current
directory to see if the current directory is the target. If it’s not,
then `make` changes to the target directory and re-invokes itself, using
the `-f` option to point back to the correct makefile from the source
directory. If `make` is in the target directory, then it builds the
requested targets.

How can this be done? It’s not difficult, but it requires a few tricky
bits. Basically, we enclose almost the entire makefile in an
`if-then-else` statement. The test of the `if` statement checks the
current directory. The `then` clause jumps to the target directory. The
`else` clause contains normal `make` rules, writing targets to the
current directory. I use GNU `make`‘s `include` preprocessor feature to
keep individual makefiles simpler-looking.

Single Target Directory
----------------------------------

We’ll start with the basic case: each source directory is completely
built in a single target directory.

### Standard Makefile Template

Here’s a sample makefile:

    ifeq (,$(filter _%,$(notdir $(CURDIR))))
    include target.mk
    else
    #----- End Boilerplate

    VPATH = $(SRCDIR)

    Normal makefile rules here

    #----- Begin Boilerplate
    endif

Note the first and last sections are the same in every makefile. The
included file hides all the tricky bits from the casual user. All the
user needs to do is create her makefile in the *Normal makefile rules
here* section, without worrying about where the targets go or where the
source files are. These rules are written as if everything occurs in the
current directory.

Let’s go through this line-by-line:

`ifeq (,$(filter _%,$(notdir $(CURDIR))))`
This is the moment of truth. This tests whether or not we are already in
the target directory, or not. Depending on the results of this test
`make` will see the rules in `target.mk`, *or* it will see the rules the
user has written in this makefile (never both!).
The test you use will likely depend on your environment. The example
here is a very simple one: in this environment I have a rule that all
target directories will begin with an underscore (`_`) and that no
source directories will begin with an underscore. This is nice because
it groups all the target directories together and early in any directory
listing, making them easy to find; it is a simple rule everyone can
follow and which could even be tested for by triggers in your source
control system to enforce; and it makes testing whether we’re in the
target directory a simple matter of checking the current directory name
to see if it starts with an underscore.

Another common test would involve comparing the target directory name
with the current directory name, or some derivatives thereof. In this
case, you need to compute the target directory name before the
`if`-statement. In situations like that I prefer to `include` another
file before the `if`-statement, say `include setup.mk`, that calculates
the value of \$(OBJDIR). Don’t duplicate that calculation in every
makefile, of course! However, it’s simplest if you can come up with an
easy rule that can be tested merely by looking at the current directory
itself.
`include target.mk`
The `target.mk` file contains all the super-magic bits that make the
entire thing work. It is processed when (and only when) the user invokes
`make` in the source directory, and it’s responsible for inducing `make`
to leap over into the architecture directory and restart itself there.
See below for details.
`else`
We had an `if`; here’s the `else`…
`VPATH = $(SRCDIR)`
Remember that this method relies on using VPATH to find the sources;
well, here it is! The previous fancy bits will cause the variable
\$(SRCDIR) to always contain the full path to the directory containing
the sources, so we are merely saying “anything you don’t find here, look
for in \$(SRCDIR)”.
Feel free to move this elsewhere (likely you have your own common
makefiles you want to include, for example), use `vpath` instead, or
whatever. Just be sure that *somewhere* you tell `make` where to find
the source directory!
`endif`
The end of the `if` statement. You shouldn’t put **anything** after this
(at least, I can’t think of anything useful to put here).
Not too bad. So, what’s in this magical `target.mk` file?

### The `target.mk` Makefile

This file is where all the magical bits are hidden. If make is parsing
this file, it means that the user invoked the build in the source
directory and we want to convince `make` to throw us over into the
target directory. Of course, we want to preserve all the same command
line values the user provided, etc.!

Here we go:

    .SUFFIXES:

    ifndef _ARCH
    _ARCH := $(shell print_arch)
    export _ARCH
    endif

    OBJDIR := _$(_ARCH)

    MAKETARGET = $(MAKE) --no-print-directory -C $@ -f $(CURDIR)/Makefile \
                     SRCDIR=$(CURDIR) $(MAKECMDGOALS)

    .PHONY: $(OBJDIR)
    $(OBJDIR):
            +@[ -d $@ ] || mkdir -p $@
            +@$(MAKETARGET)

    Makefile : ;
    %.mk :: ;

    % :: $(OBJDIR) ; :

    .PHONY: clean
    clean:
            rm -rf $(OBJDIR)

Let’s see what’s going on here.

`.SUFFIXES:`
This is the first magic bit. This forces all (well, almost all) the
builtin rules to be removed. This is crucial: we don’t want `make` to
know how to build anything. Below, we’ll tell it how to build
everything, and we don’t want it using any other rules.
To be truly comprehensive, it’s best to invoke `make` with the `-r`
option. However, that usually means you need a wrapper around `make`
that users will run, so they don’t forget. In my opinion a `make`
wrapper script is a great idea and I always use one, but opinions
differ.

Even if you do add `-r`, this line doesn’t hurt.
`ifndef _ARCH _ARCH := $(shell print_arch) export _ARCH endif`
```OBJDIR := _$(_ARCH)`
This section calculates the value of \$(OBJDIR). This example is a
little complicated; your version could be much simpler, as long as it
sets \$(OBJDIR).
Here, a variable `_ARCH` is initialized to the output of a shell script
`print_arch`. That’s just some script you can knock off that uses
`uname` or whatever is handy to determine what type of system you’re
running on, then formats it into a simple string (suitable for a
directory name–no spaces, etc.) and echos it. Exactly what that means is
up to your environment, of course.

We try to gain a little efficiency by only invoking the shell once per
build invocation: only if \$(\_ARCH) is not already set do we invoke the
shell, and after it’s set `make` exports the value into the environment
for sub-makes. Note you need to be sure users don’t accidentally have
`_ARCH` in their environments before they invoke `make`–if you’re
worried about this either calculate it every time (remove the
`if`-statement), or use a *really* obscure variable name (it must be a
valid shell variable name, though, or it won’t be exported!)

You may note I don’t use `_ARCH` elsewhere in the examples; it’s left as
a separate variable here because it can be handy to have in user’s
makefiles. For example, in the past I’ve used some functions to
transform the value into a C identifier, added “`-D`” to the front, and
stuck it into `CPPFLAGS` for those times you just have to be
system-specific.

In this example I set \$(OBJDIR) by simply adding an underscore to the
beginning of `_ARCH`, to give all the target directories a common prefix
that makes them simpler to find and manipulate. You may want to do more
here: perhaps you want to differentiate the value of `OBJDIR` based on
flags (debugging vs. optimizing vs. profiling, etc.) Whatever
specializations you want to make, though, must be made here.

In this example I have set the target directory to appear as simple
subdirectory of the source directory. However, if you prefer, `OBJDIR`
could be a full or relative pathname instead.
` MAKETARGET = $(MAKE) --no-print-directory -C $@ -f $(CURDIR)/Makefile \ SRCDIR=$(CURDIR) $(MAKECMDGOALS)`
This is merely a shorthand variable containing the actual make command
invoked to build in the target directory. Briefly,
`--no-print-directory` is used to hide the fact that we’re jumping to
the target directory; `-C $@` is used to run the sub-make in the target
directory; `-f $(CURDIR)/Makefile` tells the sub-make where to find the
makefile (remember that when we invoke this we’re in the source
directory, so \$(CURDIR) is the source directory); `SRCDIR=$(CURDIR)`
overrides the value of `SRCDIR` in the sub-make to point to the source
directory; and finally `$(MAKECMDGOALS)` invokes the sub-make with all
the goals the original make was invoked with.
`.PHONY: $(OBJDIR) $(OBJDIR): +@[ -d $@ ] || mkdir -p $@ +@$(MAKETARGET)`
This is the rule that actually does the relocation to the target
directory and invokes the sub-make there. The first line merely ensures
the directory exists, and if it doesn’t it’s created. I prefer to have
the target directories created by the build process, on the fly, rather
than having them pre-created in the source tree. I think it’s less
messy; much simpler to clean up (just delete the entire target
directory!); it’s a useful hint as to what parts of the tree have been
built and for what architectures: just look and see what directories
exist; and finally, and most importantly, it means you don’t need to go
through your source tree creating tons of new directories to add a new
architecture, or remove or rename an existing one.
The second line, of course, invokes the make rule we described above.

We use the `+` operator to ensure this jump is made even when the `-n`
option is given to make, and the `@` operator to hide the clutter of the
jump itself from the user.

We use the directory name (\$(OBJDIR)) as the target just as a
convenience; you can use the target name on the make invocation line and
it would work. When dealing with multiple architecture directories in
one build ([see below](#multiple)), that can be useful.
`Makefile : ; %.mk :: ;`
These lines are necessary, but not immediately obvious. Below we’re
going to define a rule that will tell `make` how to build *any* target.
One thing GNU `make` always tries to do is rebuild the makefile it’s
parsing, as well as any included makefiles. Normally this isn’t a
concern (aside, perhaps, from efficiency concerns) because `make`
doesn’t know how to build those files. Without these lines, then, `make`
will attempt to rebuild the makefiles using the match-anything rule,
invoking itself recursively in the target directory! Not good.
These rules override that, by defining explicit empty commands to build
the Makefile and any other files ending in `.mk` (if you use a different
naming convention for makefiles you’ll obviously need to change the
pattern rule above).
`% :: $(OBJDIR) ; :`
This is the other extra-magic bit. When `make` is invoked, either
without any targets (and the `all:` rule is chosen) or with some targets
on the command line, it will look for a rule to build that target. Above
we’ve removed all builtin rules, and the if-statement ensures that no
rules the user wrote are visible here. The only option for `make` is
this rule, so it always uses it.
This is a “match anything” implicit rule. The pattern, just `%`, will
match any target `make` wants to build. We use the special double-colon
(`::`) separator to specify that this is a terminating “match anything”
rule; this improves efficiency. See the GNU `make` manual for details on
“match anything” rules to understand this better.

The “match anything” rule depends on the `$(OBJDIR)` rule. That means
that any target will first build the `$(OBJDIR)` target, which will
cause the sub-make to be invoked in the target directory. Once `make`
builds the `$(OBJDIR)` target once, it “knows” that target has been
updated and won’t try to build it again for this invocation. Since the
`$(OBJDIR)` target invokes the sub-make with all the command line goals,
in \$(MAKECMDGOALS), that one invocation is enough to build all the
targets the user asked for.

Quick note: why do we have “`:`” as the command to be run? That’s the
Bourne shell’s “do nothing” operator. GNU `make` is actually smart
enough to notice that your rule consists of just the “do nothing”
operator, and not exec a shell. Why don’t we just use an empty command
(a semicolon with nothing after it)? We should be able to, but if you do
then GNU `make` will print a bunch of warnings about “nothing to do”.
This is actually a bug in GNU `make`, but this workaround does the job
until it’s fixed.&gt;/td&gt;
`.PHONY: clean clean: rm -rf $(OBJDIR)`
While not strictly necessary, it’s handy to put the `clean` rules here.
By doing so we assure that they are invoked in the source directory, and
that we don’t recurse into the target directory at all.
In the environment used here, the target directory is created as needed
to hold derived object files, so there are never any source files there.
Thus, the `clean` rule is quite simply to remove the target directory
and all of its contents! This is most readily accomplished from the
source directory, rather than the target directory, and saves us an
extra invocation of `make` as well.

Multiple Target Directories
----------------------------------------

Sometimes you’ll want a single invocation of the build to create files
in multiple target directories. A common example of this is source code
generators: in this case you want to build one set of targets (the
source code) in a common target directory that can be shared by all
architectures, then compile the source code into an
architecture-specific directory. This can certainly be done with this
architecture, but it’s slightly more complicated.

In the example above we split the makefile into two parts with an
if-else statement: one part that was run when we were in the source
directory, and one part that was run when we were in the target
directory. When we have multiple target directories, we need to split
the makefile into more than two parts: an extra part for each extra
target directory. Then we’ll jump to each target directory in order and
re-invoke make there. In this example we’ll stick with one extra target
directory, so we’ll need three parts to the makefile.

### Testing for Extra Target Directories

The first complication that arises with multiple target directories is,
how do you decide if you have one or not? If all your directories have
multiple targets, you’re fine; you can modify `target.mk` to jump to
them in turn for all directories. However, most often only a few
directories will need an extra target directory, and others won’t. You
don’t want to have extra invocations of make in all your directories
when most aren’t useful, so somehow you need to decide which directories
have extra targets and which don’t.

The problem is, that information has to be specified in your makefile
*before* you include the `target.mk` file, because that file is what
needs to know.

The simplest way is to have the extra target directory exist before the
build starts, then just have the `target.mk` test to see if the
directory exists. The nice thing about this is it doesn’t require any
special setup in the source makefiles, all the complexity can be
encapsulated in `target.mk`. This is a good way to go if the extra
target directory is the same everywhere (which is often the case)—for
example, if it holds constructed source code that’s common between all
architectures you might call it `_common`, then test for that:

    EXTRATARGETS := $(wildcard _common)

Above I recommended against pre-creating target directories, but this
can be considered a special case: it will always need to exist before
any normal target can be built, so having it exist always isn’t as big
of an issue.

However, if you don’t want the directory to pre-exist, or you can’t use
this method for some other reason, the other option is to modify the
source makefile and set an EXTRATARGETS variable. The minor disadvantage
here is that it must be done by the user, and it must be set before the
`if`-statement is invoked, meaning in the boilerplate prefix section
which is no longer quite so boilerplate.

There are about as many possible ways to permute this as there are
requirements to do so; here I’m going to provide an example of a simple
case.

### Standard Makefile Template with Multiple Targets

Here’s an example of a standard source makefile for a directory that has
two targets: the `_common` target and the \$(OBJDIR) target. This
example assumes the first method of testing for the extra target
directory, done in `target.mk`. If you choose another method, you need
to insert something before the first line below.

    ifeq (,$(filter _%,$(notdir $(CURDIR))))
    include target.mk
    else
    ifeq (_common,$(notdir $(CURDIR)))
    VPATH = $(SRCDIR)
    .DEFAULT: ; @:

    Makefile rules for _common files here

    else

    VPATH = $(SRCDIR):$(SRCDIR)/_common

    Makefile rules for $(OBJDIR) files here

    endif
    endif

The new sections are in [blue text]{style="color: blue;"} above. You can
see what we’ve done: we’ve added another `if`-statement into the target
section of the makefile, splitting it into two parts. We execute the
first part if we’re in the `_common` target directory, and the second
part if we’re in the \$(OBJDIR) target directory.

In the `_common` target directory, we use VPATH to find sources in the
source directory. In the \$(OBJDIR) target directory, we use VPATH to
look in *both* the source directory *and* the `_common` directory.

There is one tricky bit here, the `.DEFAULT` rule. This rule, with a
no-op command script, essentially tells make to ignore any targets it
doesn’t know how to build. This is necessary to allow commands like
“`make foo.o`” to succeed. Remember that regardless of the target you
ask to be built, make will be invoked in both the common and the target
directories. If you don’t have this line then when `make` tries to build
`foo.o` in the common directory, it will fail. With this rule, it will
succeed while not actually doing anything, trusting the target directory
invocation to know what to do. If that invocation fails you’ll get a
normal error, since the `.DEFAULT` rule is only present in the section
of the makefile that’s handling the common directory builds.

If you have some common rules or variables that need to be set for both
the `_common` and the \$(OBJDIR) target directories, you can insert them
between the first `else` and the second `ifeq`, above; that section will
be seen by both target directory builds but not by the source directory
build.

Obviously this example is geared towards handling generated source code;
your need for multiple targets in the same build may be quite different
and not require this type of interaction.

### The `target.mk` File with Multiple Targets

In the last section we saw how the user separates her rules into
different sections depending on which target directory is being built.
Let’s see how to write a `target.mk` file that allows jumping into
multiple target directories. It’s fairly straightforward.

    .SUFFIXES:

    ifndef _ARCH
    _ARCH := $(shell print_arch)
    export _ARCH
    endif

    OBJDIR := _$(_ARCH)

    MAKETARGET = $(MAKE) --no-print-directory -C $@ -f $(CURDIR)/Makefile \
                     SRCDIR=$(CURDIR) $(MAKECMDGOALS)

    EXTRATARGETS := $(wildcard _common)

    .PHONY: $(OBJDIR) $(EXTRATARGETS)
    $(OBJDIR) $(EXTRATARGETS):
            +@[ -d $@ ] || mkdir -p $@
            +@$(MAKETARGET)

    $(OBJDIR) : $(EXTRATARGETS)

    Makefile : ;
    %.mk :: ;

    % :: $(EXTRATARGETS) $(OBJDIR) ; :

    .PHONY: clean
    clean:
            $(if $(EXTRATARGETS),rm -f $(EXTRATARGETS)/*)
            rm -rf $(OBJDIR)

Again, additions to this file from the previous example are in [blue
text]{style="color: blue;"}.

The first change sets the variable `EXTRATARGETS` to `_common` if that
directory exists, or empty if it doesn’t. If you are using a different
method of determining the value of \$(EXTRATARGETS) you can change this
line (or, leave it out if the source makefile is setting it for you).

Next, we include the value of \$(EXTRATARGETS) (if any) as a phony
target to be built, and use the same sub-make invocation rule for
building it as we use for \$(OBJDIR).

Next we declare a dependency relationship between \$(OBJDIR) and
\$(EXTRATARGETS) (if it exists) to ensure that \$(EXTRATARGETS) is built
first; in our environment that’s what we want since \$(OBJDIR) depends
on the results of that build. If your situation is different, you can
omit or modify this line. However, *if* there is a dependency between
these two you must declare it. Otherwise, `make` might do the wrong
thing, especially in the presence of a parallel build situation.

We add \$(EXTRATARGETS) to the prerequisite line for the match-anything
rule. In this case, since we declared the dependency relationship above,
we could have omitted this and achieved the same result.

Finally, if \$(EXTRATARGETS) exists we remove its contents during the
`clean` rule. Remember that in this scenario the presence or absence of
the `_common` directory is what notifies us that there is an extra
target directory, so we must be careful not to remove the directory
itself, only its contents. The `if`-statement will expand to an empty
string if \$(EXTRATARGETS) doesn’t exist.

Sample Implementation
--------------------------------

You can download a very small sample implementation of the above method
[right here](/multi-example.tar.gz). Uncompress and untar the file, then
change to the `example` directory and run `make`.

This trivial example merely transforms a `version.c.in` file into an
`_common/version.c` file, using `sed` to install a version number. Then
it creates an executable in the target directory:

    example$ make
    sed 's/@VERSION@/1.0/g' /tmp/example/version.c.in > version.c
    cc /tmp/example/_common/version.c -o version

    example$ ls _*
    _Linux:
    version

    _common:
    version.c

    example$ _Linux/version
    The version is `1.0'.

Now, if you override `OBJDIR` to have a different value you can see that
`version.c` is not recreated, as it’s common between all the targets,
but a new `version` binary is built:

    example$ make OBJDIR=_Test
    cc /tmp/example/_common/version.c -o version

    example$ ls _*
    _Linux:
    version

    _Test:
    version

    _common:
    version.c

    example$ _Test/version
    The version is `1.0'.

Acknowledgments
===================================

-   When I was first developing this idea back in 1991/1992, I bounced a
    number of questions off of Roland McGrath: his responses were very
    helpful.
-   The enhancement for using \$(MAKECMDGOALS) and the match-anything
    rule (instead of `.DEFAULT` as in the previous version of this
    document) was suggested to me via email by Jacob Burckhardt
    &lt;bjacob@ca.metsci.com&gt;. This also prodded me to revise and
    complete this document: when I wrote it originally \$(MAKECMDGOALS)
    didn’t exist, and I wondered what other features added since the
    original version could be useful in this method.

Thanks to all!

Revision History
============================

  ------ ---------------- ------------------------------------------------------------------
  1.00   18 August 2000   Revised.
  
  0.10   ???? 1997        Initial version posted; final sections still under construction.
  ------ ---------------- ------------------------------------------------------------------

Copyright © 1997-2021 [Paul D. Smith](http://mad-scientist.net) ·
Verbatim copying and distribution is permitted in any medium, provided
this notice is preserved.
