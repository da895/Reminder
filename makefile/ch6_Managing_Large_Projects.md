---
description: |
    Chapter 6. Managing Large Projects What do you call a large project? For
    our purposes, it is one that requires a team of developers, may run on
    multiple architectures, and … - Selection from Managing Projects with
    GNU Make, 3rd Edition \[Book\]
title: |
    6. Managing Large Projects - Managing Projects with GNU Make, 3rd
    Edition \[Book\]
twitter:card: summary
twitter:site: '@OReillyMedia'
viewport: 'width=device-width, initial-scale=1'
---

Chapter 6. Managing Large Projects {#chapter6.managing-large-projects .title}
----------------------------------

What do you call a
large project? For our purposes, it is one that requires a team of
developers, may run on multiple architectures, and may have several
field releases that require maintenance. Of course, not all of these are
required to call a project large. A million lines of prerelease C++ on a
single platform is still large. But software rarely stays prerelease
forever. And if it is successful, someone will eventually ask for it on
another platform. So most large software systems wind up looking very
similar after awhile.

Large software projects are usually simplified by dividing them into
major components, often collected into distinct programs, libraries, or
both. These components are often stored under their own directories and
managed by their own [*makefile*]{.emphasis}s. One way to build an
entire system of components employs a top-level [*makefile*]{.emphasis}
that invokes the [*makefile*]{.emphasis} for each component in the
proper order. This approach is called [*recursive make*]{.emphasis}
because the top-level [*makefile*]{.emphasis} invokes `make`{.literal}
recursively on each component’s [*makefile*]{.emphasis}. Recursive
`make`{.literal} is a common technique for handling componentwise
builds. An alternative suggested by Peter Miller in 1998 avoids many
issues with recursive `make`{.literal} by using a single
[*makefile*]{.emphasis} that includes information from each component
directory.^\[[12](#ftn.ch06fn01){#ch06fn01 .footnote}\]^

Once a project gets beyond building its components, it eventually finds
that there are larger organizational issues in managing builds. These
include handling development on multiple versions of a project,
supporting several platforms, providing efficient access to source and
binaries, and performing automated builds. We will discuss these
problems in the second half of this chapter.

Recursive make {#recursive_make .title style="clear: both"}
--------------

[]{#iddle1595 .indexterm}The motivation behind recursive make is simple:
`make`{.literal} works very well within a single directory (or small set
of directories) but becomes more complex when the number of directories
grows. So, we can use `make`{.literal} to build a large project by
writing a simple, self-contained [*makefile*]{.emphasis} for each
directory, then executing them all individually. We could use a
scripting tool to perform this execution, but it is more effective to
use `make`{.literal} itself since there are also dependencies involved
at the higher level.

For example, suppose I have an mp3 player application. It can logically
be divided into several components: the user interface, codecs, and
database management. These might be represented by three libraries:
[*libui.a*]{.emphasis}, [*libcodec.a*]{.emphasis}, and
[*libdb.a*]{.emphasis}. The application itself consists of glue holding
these pieces together. A straightforward mapping of these components
onto a file structure might look like
[Figure 6-1](ch06.html#file_layout_for_an_mp3_player "Figure 6-1. File layout for an MP3 player"){.xref}.


[]{#file_layout_for_an_mp3_player}
<div class="figure-contents">

<div class="mediaobject">

[]{#med_id00005}![File layout for an MP3
player](/library/view/managing-projects-with/0596006101/figs/web/06fig01.png.jpg){width="247"
height="630"}

</div>

</div>

<div class="figure-title">

Figure 6-1. File layout for an MP3 player

</div>

</div>

A more traditional layout would place the application’s main function
and glue in the top directory rather than in the subdirectory
[*app/player*]{.emphasis}. I prefer to put application code in its own
directory to create a cleaner layout at the top level and allow for
[]{#iddle1471 .indexterm}[]{#iddle1601 .indexterm}[]{#iddle1785
.indexterm}growth of the system with additional modules. For instance,
if we choose to add a separate cataloging application later it can
neatly fit under [*app/catalog*]{.emphasis}.

If each of the directories [*lib/db*]{.emphasis},
[*lib/codec*]{.emphasis}, [*lib/ui*]{.emphasis}, and
[*app/player*]{.emphasis} contains a [*makefile*]{.emphasis}, then it is
the job of the top-level [*makefile*]{.emphasis} to invoke them.

[]{#pro_id00301}
``` {.programlisting}
lib_codec := lib/codec
lib_db    := lib/db
lib_ui    := lib/ui
libraries := $(lib_ui) $(lib_db) $(lib_codec)
player    := app/player

.PHONY: all $(player) $(libraries)
all: $(player)

$(player) $(libraries):
        $(MAKE) --directory=$@

$(player): $(libraries)
$(lib_ui): $(lib_db) $(lib_codec)
```

The top-level [*makefile*]{.emphasis} invokes `make`{.literal} on each
subdirectory through a rule that lists the subdirectories as targets and
whose action is to invoke `make`{.literal}:

[]{#pro_id00302}
``` {.programlisting}
$(player) $(libraries):
        $(MAKE) --directory=$@
```

The variable `MAKE`{.literal} should always be used to invoke
`make`{.literal} within a [*makefile*]{.emphasis}. The `MAKE`{.literal}
variable is recognized by `make`{.literal} and is set to the actual path
of `make`{.literal} so recursive invocations all use the same
executable. Also, lines containing the variable `MAKE`{.literal} are
handled specially when the command-line options `--touch`{.literal}
(`-t`{.literal}), `--just-print`{.literal} (`-n`{.literal}), and
`--question`{.literal} (`-q`{.literal}) are used. We’ll discuss this in
detail in the section [Command-Line
Options](ch06.html#command-line_options "Command-Line Options"){.xref}
later in this chapter.

The target directories are marked with `.PHONY`{.literal} so the rule
fires even though the target may be up to date. The
`--directory`{.literal} (`-C`{.literal}) option is used to cause
`make`{.literal} to change to the target directory before reading a
[*makefile*]{.emphasis}.

This rule, although a bit subtle, overcomes several problems associated
with a more straightforward command script:

[]{#pro_id00303}
``` {.programlisting}
all:
        for d in $(player) $(libraries); \
        do                               \
          $(MAKE) --directory=$$d;       \
        done
```

This command script fails to properly transmit errors to the parent
`make`{.literal}. It also does not allow `make`{.literal} to execute any
subdirectory builds in parallel. We’ll discuss this feature of
`make`{.literal} in
[Chapter 10](ch10.html "Chapter 10. Improving the Performance of make"){.xref}.

As `make`{.literal} is planning the execution of the dependency graph,
the prerequisites of a target are independent of one another. In
addition, separate targets with no dependency []{#iddle1202
.indexterm}[]{#iddle1441 .indexterm}[]{#iddle1584
.indexterm}[]{#iddle1599 .indexterm}[]{#iddle1748
.indexterm}relationships to one another are also independent. For
example, the libraries have no [*inherent*]{.emphasis} relationship to
the `app/player`{.literal} target or to each other. This means
`make`{.literal} is free to execute the [*app/player
makefile*]{.emphasis} before building any of the libraries. Clearly,
this would cause the build to fail since linking the application
requires the libraries. To solve this problem, we provide additional
dependency information.

[]{#pro_id00304}
``` {.programlisting}
$(player): $(libraries)
$(lib_ui): $(lib_db) $(lib_codec)
```

Here we state that the [*makefile*]{.emphasis}s in the library
subdirectories must be executed before the [*makefile*]{.emphasis} in
the `player`{.literal} directory. Similarly, the [*lib/ui*]{.emphasis}
code requires the [*lib/db*]{.emphasis} and [*lib/codec*]{.emphasis}
libraries to be compiled. This ensures that any generated code (such as
`yacc`{.literal}/`lex`{.literal} files) have been generated before the
[*ui*]{.emphasis} code is compiled.

There is a further subtle ordering issue when updating prerequisites. As
with all dependencies, the order of updating is determined by the
analysis of the dependency graph, but when the prerequisites of a target
are listed on a single line, GNU `make`{.literal} happens to update them
from left to right. For example:

[]{#pro_id00305}
``` {.programlisting}
all: a b c
all: d e f
```

If there are no other dependency relationships to be considered, the six
prerequisites can be updated in any order (e.g., “d b a c e f”), but GNU
`make`{.literal} uses left to right within a single target line,
yielding the update order: “a b c d e f” [*or*]{.emphasis} “d e f a b
c.” Although this ordering is an accident of the implementation, the
order of execution appears correct. It is easy to forget that the
correct order is a happy accident and fail to provide full dependency
information. Eventually, the dependency analysis will yield a different
order and cause problems. So, if a set of targets must be updated in a
specific order, enforce the proper order with appropriate prerequisites.

When the top-level [*makefile*]{.emphasis} is run, we see:

[]{#pro_id00306}
``` {.programlisting}
$ make
make --directory=lib/db
make[1]: Entering directory `/test/book/out/ch06-simple/lib/db'
Update db library...
make[1]: Leaving directory `/test/book/out/ch06-simple/lib/db'
make --directory=lib/codec
make[1]: Entering directory `/test/book/out/ch06-simple/lib/codec'
Update codec library...
make[1]: Leaving directory `/test/book/out/ch06-simple/lib/codec'
make --directory=lib/ui
make[1]: Entering directory `/test/book/out/ch06-simple/lib/ui'
Update ui library...
make[1]: Leaving directory `/test/book/out/ch06-simple/lib/ui'
make --directory=app/player
make[1]: Entering directory `/test/book/out/ch06-simple/app/player'
Update player application...
make[1]: Leaving directory `/test/book/out/ch06-simple/app/player'
```

[]{#iddle1114 .indexterm}[]{#iddle1528 .indexterm}[]{#iddle1598
.indexterm}[]{#iddle1602 .indexterm}[]{#iddle1799 .indexterm}When
`make`{.literal} detects that it is invoking another `make`{.literal}
recursively, it enables the `--print-directory`{.literal}
(`-w`{.literal}) option, which causes `make`{.literal} to print the
`Entering directory`{.literal} and `Leaving directory`{.literal}
messages. This option is also enabled when the `--directory`{.literal}
(`-C`{.literal}) option is used. The value of the `make`{.literal}
variable `MAKELEVEL`{.literal} is printed in square brackets in each
line as well. In this simple example, each component
[*makefile*]{.emphasis} prints a simple message about updating the
component.

<div class="sect2" title="Command-Line Options">

<div class="titlepage">

<div>

<div>

### Command-Line Options {#command-line_options .title}

</div>

</div>

</div>

Recursive `make`{.literal} is a simple idea that quickly becomes
complicated. The perfect recursive `make`{.literal} implementation would
behave as if the many [*makefile*]{.emphasis}s in the system are a
single [*makefile*]{.emphasis}. Achieving this level of coordination is
virtually impossible, so compromises must be made. The subtle issues
become more clear when we look at how command-line options must be
handled.

Suppose we have added comments to a header file in our mp3 player.
Rather than recompiling all the source that depends on the modified
header, we realize we can instead perform a `make --touch`{.literal} to
bring the timestamps of the files up to date. By executing the
`make --touch`{.literal} with the top-level [*makefile,*]{.emphasis} we
would like `make`{.literal} to touch all the appropriate files managed
by sub-`make`{.literal}s. Let’s see how this works.

Usually, when `--touch`{.literal} is provided on the command line, the
normal processing of rules is suspended. Instead, the dependency graph
is traversed and the selected targets and those prerequisites that are
not marked `.PHONY`{.literal} are brought up to date by executing
`touch`{.literal} on the target. Since our subdirectories are marked
`.PHONY`{.literal}, they would normally be ignored (touching them like
normal files would be pointless). But we don’t want those targets
ignored, we want their command script executed. To do the right thing,
`make`{.literal} automatically labels any line containing
`MAKE`{.literal} with the `+`{.literal} modifier, meaning
`make`{.literal} runs the sub-`make`{.literal} regardless of the
`--touch`{.literal} option.

When `make`{.literal} runs the sub-`make`{.literal} it must also arrange
for the `--touch`{.literal} flag to be passed to the sub-process. It
does this through the `MAKEFLAGS`{.literal} variable. When
`make`{.literal} starts, it automatically appends most command-line
options to `MAKEFLAGS`{.literal}. The only exceptions are the options
`--directory`{.literal} (`-C`{.literal}), `--file`{.literal}
(`-f`{.literal}), `--old-file`{.literal} (`-o`{.literal}), and
`--new-file`{.literal} (`-W`{.literal}). The `MAKEFLAGS`{.literal}
variable is then exported to the environment and read by the
sub-`make`{.literal} as it starts.

With this special support, sub-`make`{.literal}s behave mostly the way
you want. The recursive execution of `$(MAKE)`{.literal} and the special
handling of `MAKEFLAGS`{.literal} that is applied to `--touch`{.literal}
(`-t`{.literal}) is also applied to the options `--just-print`{.literal}
(`-n`{.literal}) and `--question`{.literal} (`-q`{.literal}).

</div>

<div class="sect2" title="Passing Variables">

<div class="titlepage">

<div>

<div>

### Passing Variables {#passing_variables .title}

</div>

</div>

</div>

As we have already mentioned, variables are passed to
sub-`make`{.literal}s through the environment and controlled using the
`export`{.literal} and `unexport`{.literal} directives. Variables passed
through the environment are taken as default values, but are overridden
by any []{#iddle1074 .indexterm}[]{#iddle1246 .indexterm}[]{#iddle1596
.indexterm}[]{#iddle1600 .indexterm}[]{#iddle1716 .indexterm}assignment
to the variable. Use the `--environment-overrides`{.literal}
(`-e`{.literal}) option to allow environment variables to override the
local assignment. You can explicitly override the environment for a
specific assignment (even when the `--environment-overrides`{.literal}
option is used) with the `override`{.literal} directive:

[]{#pro_id00307}
``` {.programlisting}
override TMPDIR = ~/tmp
```

Variables defined on the command line are automatically exported to the
environment if they use legal shell syntax. A variable is considered
legal if it uses only letters, numbers, and underscores. Variable
assignments from the command line are stored in the
`MAKEFLAGS`{.literal} variable along with command-line options.

</div>

<div class="sect2" title="Error Handling">

<div class="titlepage">

<div>

<div>

### Error Handling {#error_handling .title}

</div>

</div>

</div>

What happens when a recursive `make`{.literal} gets an error? Nothing
very unusual, actually. The `make`{.literal} receiving the error status
terminates its processing with an exit status of 2. The parent
`make`{.literal} then exits, propagating the error status up the
recursive `make`{.literal} process tree. If the `--keep-going`{.literal}
(`-k`{.literal}) option is used on the top-level `make`{.literal}, it is
passed to sub-`make`{.literal}s as usual. The sub-`make`{.literal} does
what it normally does, skips the current target and proceeds to the next
goal that does not use the erroneous target as a prerequisite.

For example, if our mp3 player program encountered a compilation error
in the `lib/db`{.literal} component, the `lib/db make`{.literal} would
exit, returning a status of 2 to the top-level [*makefile*]{.emphasis}.
If we used the `--keep-going`{.literal} (`-k`{.literal}) option, the
top-level [*makefile*]{.emphasis} would proceed to the next unrelated
target, `lib/codec`{.literal}. When it had completed that target,
regardless of its exit status, the `make`{.literal} would exit with a
status of 2 since there are no further targets that can be processed due
to the failure of `lib/db`{.literal}.

The `--question`{.literal} (`-q`{.literal}) option behaves very
similarly. This option causes `make`{.literal} to return an exit status
of 1 if some target is not up to date, 0 otherwise. When applied to a
tree of [*makefile*]{.emphasis}s, `make`{.literal} begins recursively
executing [*makefile*]{.emphasis}s until it can determine if the project
is up to date. As soon as an out-of-date file is found, `make`{.literal}
terminates the currently active `make`{.literal} and unwinds the
recursion.

</div>

<div class="sect2" title="Building Other Targets">

<div class="titlepage">

<div>

<div>

### Building Other Targets {#building_other_targets .title}

</div>

</div>

</div>

The basic build target is essential for any build system, but we also
need the other support targets we’ve come to depend upon, such as
`clean`{.literal}, `install`{.literal}, `print`{.literal}, etc. Because
these are `.PHONY`{.literal} targets, the technique described earlier
doesn’t work very well.

For instance, there are several broken approaches, such as:

[]{#pro_id00308}
``` {.programlisting}
clean: $(player) $(libraries)
        $(MAKE) --directory=$@ clean
```

or:

[]{#pro_id00309}
``` {.programlisting}
$(player) $(libraries):
        $(MAKE) --directory=$@ clean
```

[]{#iddle1195 .indexterm}The first is broken because the prerequisites
would trigger a build of the default target in the `$(player)`{.literal}
and `$(libraries)`{.literal} [*makefile*]{.emphasis}s, not a build of
the `clean`{.literal} target. The second is illegal because these
targets already exist with a different command script.

One approach that works relies on a shell `for`{.literal} loop:

[]{#pro_id00310}
``` {.programlisting}
clean:
        for d in $(player) $(libraries); \
        do                               \
          $(MAKE) --directory=$$d clean; \
        done
```

A `for`{.literal} loop is not very satisfying for all the reasons
described earlier, but it (and the preceding illegal example) points us
to this solution:

[]{#pro_id00311}
``` {.programlisting}
$(player) $(libraries):
        $(MAKE) --directory=$@ $(TARGET)
```

By adding the variable `$(TARGET)`{.literal} to the recursive
`make`{.literal} line and setting the `TARGET`{.literal} variable on the
`make`{.literal} command line, we can add arbitrary goals to the
sub-`make`{.literal}:

[]{#pro_id00312}
``` {.programlisting}
$ make TARGET=clean
```

Unfortunately, this does not invoke the `$(TARGET)`{.literal} on the
top-level [*makefile*]{.emphasis}. Often this is not necessary because
the top-level [*makefile*]{.emphasis} has nothing to do, but, if
necessary, we can add another invocation of `make`{.literal} protected
by an `if`{.literal}:

[]{#pro_id00313}
``` {.programlisting}
$(player) $(libraries):
        $(MAKE) --directory=$@ $(TARGET)
        $(if $(TARGET), $(MAKE) $(TARGET))
```

Now we can invoke the `clean`{.literal} target (or any other target) by
simply setting `TARGET`{.literal} on the command line.

</div>

<div class="sect2" title="Cross-Makefile Dependencies">

<div class="titlepage">

<div>

<div>

### Cross-Makefile Dependencies {#cross-makefile_dependencies .title}

</div>

</div>

</div>

The special support in `make`{.literal} for command-line options and
communication through environment variables suggests that recursive
`make`{.literal} has been tuned to work well. So what are the serious
complications alluded to earlier?

Separate [*makefile*]{.emphasis}s linked by recursive
`$(MAKE)`{.literal} commands record only the most superficial top-level
links. Unfortunately, there are often subtle dependencies buried in some
directories.

For example, suppose a [*db*]{.emphasis} module includes a
`yacc`{.literal}-based parser for importing and exporting music data. If
the [*ui*]{.emphasis} module, [*ui.c*]{.emphasis}, includes the
generated `yacc`{.literal} header, we have a dependency between these
two modules. If the dependencies are properly modeled, `make`{.literal}
should know to recompile our [*ui*]{.emphasis} module whenever the
grammar header is updated. This is not difficult to arrange using the
automatic dependency generation technique described earlier. But what if
the `yacc`{.literal} file itself is modified? In this case, when the
[*ui makefile*]{.emphasis} is run, a correct [*makefile*]{.emphasis}
would recognize that `yacc`{.literal} must first be run to generate the
parser and header before compiling [*ui.c*]{.emphasis}. In our
[]{#iddle1104 .indexterm}[]{#iddle1597 .indexterm}recursive
`make`{.literal} decomposition, this does not occur, because the rule
and dependencies for running `yacc`{.literal} are in the [*db
makefile*]{.emphasis}, not the [*ui makefile*]{.emphasis}.

In this case, the best we can do is to ensure that the [*db
makefile*]{.emphasis} is always executed before executing the [*ui
makefile*]{.emphasis}. This higher-level dependency must be encoded by
hand. We were astute enough in the first version of our
[*makefile*]{.emphasis} to recognize this, but, in general, this is a
very difficult maintenance problem. As code is written and modified, the
top-level [*makefile*]{.emphasis} will fail to properly record the
intermodule dependencies.

To continue the example, if the `yacc`{.literal} grammar in
[*db*]{.emphasis} is updated and the [*ui makefile*]{.emphasis} is run
before the [*db makefile*]{.emphasis} (by executing it directly instead
of through the top-level [*makefile*]{.emphasis}), the [*ui
makefile*]{.emphasis} does not know there is an unsatisfied dependency
in the [*db makefile*]{.emphasis} and that `yacc`{.literal} must be run
to update the header file. Instead, the [*ui makefile*]{.emphasis}
compiles its program with the old `yacc`{.literal} header. If new
symbols have been defined and are now being referenced, then a
compilation error is reported. Thus, the recursive `make`{.literal}
approach is inherently more fragile than a single
[*makefile*]{.emphasis}.

The problem worsens when code generators are used more extensively.
Suppose that the use of an RPC stub generator is added to
[*ui*]{.emphasis} and the headers are referenced in [*db*]{.emphasis}.
Now we have mutual reference to contend with. To resolve this, it may be
required to visit [*db*]{.emphasis} to generate the `yacc`{.literal}
header, then visit [*ui*]{.emphasis} to generate the RPC stubs, then
visit [*db*]{.emphasis} to compile the files, and finally visit
[*ui*]{.emphasis} to complete the compilation process. The number of
passes required to create and compile the source for a project is
dependent on the structure of the code and the tools used to create it.
This kind of mutual reference is common in complex systems.

The standard solution in real-world [*makefile*]{.emphasis}s is usually
a hack. To ensure that all files are up to date, every
[*makefile*]{.emphasis} is executed when a command is given to the
top-level [*makefile*]{.emphasis}. Notice that this is precisely what
our mp3 player [*makefile*]{.emphasis} does. When the top-level
[*makefile*]{.emphasis} is run, each of the four
sub-[*makefile*]{.emphasis}s is unconditionally run. In complex cases,
[*makefile*]{.emphasis}s are run repeatedly to ensure that all code is
first generated then compiled. Often this iterative execution is a
complete waste of time, but occasionally it is required.

</div>

<div class="sect2" title="Avoiding Duplicate Code">

<div class="titlepage">

<div>

<div>

### Avoiding Duplicate Code {#avoiding_duplicate_code .title}

</div>

</div>

</div>

The directory layout of our application includes three libraries. The
[*makefile*]{.emphasis}s for these libraries are very similar. This
makes sense because the three libraries serve different purposes in the
final application but are all built with similar commands. This kind of
decomposition is typical of large projects and leads to many similar
[*makefile*]{.emphasis}s and lots of ([*makefile*]{.emphasis}) code
duplication.

Code duplication is bad, even [*makefile*]{.emphasis} code duplication.
It increases the maintenance costs of the software and leads to more
bugs. It also makes it more difficult to understand algorithms and
identify minor variations in them. So we would like to avoid code
duplication in our [*makefile*]{.emphasis}s as much as possible. This is
most easily accomplished by moving the common pieces of a
[*makefile*]{.emphasis} into a common include file.

For example, the [*codec makefile*]{.emphasis} contains:

[]{#pro_id00314}
``` {.programlisting}
lib_codec    := libcodec.a
sources      := codec.c
objects      := $(subst .c,.o,$(sources))
dependencies := $(subst .c,.d,$(sources))

include_dirs := .. ../../include
CPPFLAGS     += $(addprefix -I ,$(include_dirs))
vpath %.h $(include_dirs)

all: $(lib_codec)

$(lib_codec): $(objects)
        $(AR) $(ARFLAGS) $@ $^

.PHONY: clean
clean:
        $(RM) $(lib_codec) $(objects) $(dependencies)

ifneq "$(MAKECMDGOALS)" "clean"
  include $(dependencies)
endif

%.d: %.c
        $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -M $< |      \
        sed 's,\($*\.o\) *:,\1 $@: ,' > $@.tmp
        mv $@.tmp $@
```

Almost all of this code is duplicated in the [*db*]{.emphasis} and [*ui
makefile*]{.emphasis}s. The only lines that change for each library are
the name of the library itself and the source files the library
contains. When duplicate code is moved into [*common.mk*]{.emphasis}, we
can pare this [*makefile*]{.emphasis} down to:

[]{#pro_id00315}
``` {.programlisting}
library := libcodec.a
sources := codec.c

include ../../common.mk
```

See what we have moved into the single, shared include file:

[]{#pro_id00316}
``` {.programlisting}
MV           := mv -f
RM           := rm -f
SED          := sed

objects      := $(subst .c,.o,$(sources))
dependencies := $(subst .c,.d,$(sources))
include_dirs := .. ../../include
CPPFLAGS     += $(addprefix -I ,$(include_dirs))

vpath %.h $(include_dirs)

.PHONY: library
library: $(library)

$(library): $(objects)
        $(AR) $(ARFLAGS) $@ $^

.PHONY: clean
clean:
        $(RM) $(objects) $(program) $(library) $(dependencies) $(extra_clean)

ifneq "$(MAKECMDGOALS)" "clean"
  -include $(dependencies)
endif

%.c %.h: %.y
        $(YACC.y) --defines $<
        $(MV) y.tab.c $*.c
        $(MV) y.tab.h $*.h

%.d: %.c
        $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -M $< |      \
        $(SED) 's,\($*\.o\) *:,\1 $@: ,' > $@.tmp
        $(MV) $@.tmp $@
```

The variable `include_dirs`{.literal}, which was different for each
[*makefile*]{.emphasis}, is now identical in all
[*makefile*]{.emphasis}s because we reworked the path source files use
for included headers to make all libraries use the same include path.

The [*common.mk*]{.emphasis} file even includes the default goal for the
library include files. The original [*makefile*]{.emphasis}s used the
default target `all`{.literal}. That would cause problems with
nonlibrary [*makefile*]{.emphasis}s that need to specify a different set
of prerequisites for their default goal. So the shared code version uses
a default target of `library`{.literal}.

Notice that because this common file contains targets it must be
included after the default target for nonlibrary
[*makefile*]{.emphasis}s. Also notice that the `clean`{.literal} command
script references the variables `program`{.literal},
`library`{.literal}, and `extra_clean`{.literal}. For library
[*makefile*]{.emphasis}s, the `program`{.literal} variable is empty; for
program [*makefile*]{.emphasis}s, the `library`{.literal} variable is
empty. The `extra_clean`{.literal} variable was added specifically for
the [*db makefile*]{.emphasis}. This [*makefile*]{.emphasis} uses the
variable to denote code generated by `yacc`{.literal}. The
[*makefile*]{.emphasis} is:

[]{#pro_id00317}
``` {.programlisting}
library     := libdb.a
sources     := scanner.c playlist.c
extra_clean := $(sources) playlist.h

.SECONDARY: playlist.c playlist.h scanner.c

include ../../common.mk
```

Using these techniques, code duplication can be kept to a minimum. As
more [*makefile*]{.emphasis} code is moved into the common
[*makefile*]{.emphasis}, it evolves into a generic
[*makefile*]{.emphasis} for the entire project. `make`{.literal}
variables and user-defined functions are used as customization points,
allowing the generic [*makefile*]{.emphasis} to be modified for each
directory.

</div>

</div>

<div class="sect1" title="Nonrecursive make">

<div class="titlepage">

<div>

<div>

Nonrecursive make {#nonrecursive_make .title style="clear: both"}
-----------------

</div>

</div>

</div>

[]{#iddle1218 .indexterm}[]{#iddle1504 .indexterm}[]{#iddle1554
.indexterm}Multidirectory projects can also be managed without recursive
`make`{.literal}s. The difference here is that the source manipulated by
the [*makefile*]{.emphasis} lives in more than one directory. To
accommodate this, references to files in subdirectories must include the
path to the file—either absolute or relative.

Often, the [*makefile*]{.emphasis} managing a large project has many
targets, one for each module in the project. For our mp3 player example,
we would need targets for each of the libraries and each of the
applications. It can also be useful to add phony targets for collections
of modules such as the collection of all libraries. The default goal
would typically build all of these targets. Often the default goal
builds documentation and runs a testing procedure as well.

The most straightforward use of nonrecursive `make`{.literal} includes
targets, object file references, and dependencies in a single
[*makefile*]{.emphasis}. This is often unsatisfying to developers
familiar with recursive `make`{.literal} because information about the
files in a directory is centralized in a single file while the source
files themselves are distributed in the filesystem. To address this
issue, the Miller paper on nonrecursive `make`{.literal} suggests using
one `make`{.literal} include file for each directory containing file
lists and module-specific rules. The top-level [*makefile*]{.emphasis}
includes these sub-[*makefile*]{.emphasis}s.

[Example 6-1](ch06.html#nonrecursive_makefile "Example 6-1. A nonrecursive makefile"){.xref}
shows a [*makefile*]{.emphasis} for our mp3 player that includes a
module-level [*makefile*]{.emphasis} from each subdirectory.
[Example 6-2](ch06.html#libsoliduscodec_include_file_for_a_nonre "Example 6-2. The lib/codec include file for a nonrecursive makefile"){.xref}
shows one of the module-level include files.

<div class="example">

[]{#nonrecursive_makefile}
<div class="example-title">

Example 6-1. A nonrecursive makefile

</div>

<div class="example-contents">

``` {.programlisting}
# Collect information from each module in these four variables.
# Initialize them here as simple variables.
programs     :=
sources      :=
libraries    :=
extra_clean  :=

objects      = $(subst .c,.o,$(sources))
dependencies = $(subst .c,.d,$(sources))

include_dirs := lib include
CPPFLAGS     += $(addprefix -I ,$(include_dirs))
vpath %.h $(include_dirs)

MV  := mv -f
RM  := rm -f
SED := sed

all:

include lib/codec/module.mk
include lib/db/module.mk
include lib/ui/module.mk
include app/player/module.mk

.PHONY: all
all: $(programs)

.PHONY: libraries
libraries: $(libraries)

.PHONY: clean
clean:
        $(RM) $(objects) $(programs) $(libraries) \
              $(dependencies) $(extra_clean)

ifneq "$(MAKECMDGOALS)" "clean"
  include $(dependencies)
endif

%.c %.h: %.y
        $(YACC.y) --defines $<
        $(MV) y.tab.c $*.c
        $(MV) y.tab.h $*.h

%.d: %.c
        $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -M $< | \
        $(SED) 's,\($(notdir $*)\.o\) *:,$(dir $@)\1 $@: ,' > $@.tmp
        $(MV) $@.tmp $@
```

</div>

</div>

<div class="example">

[]{#libsoliduscodec_include_file_for_a_nonre}
<div class="example-title">

Example 6-2. The lib/codec include file for a nonrecursive makefile

</div>

<div class="example-contents">

``` {.programlisting}
local_dir  := lib/codec
local_lib  := $(local_dir)/libcodec.a
local_src  := $(addprefix $(local_dir)/,codec.c)
local_objs := $(subst .c,.o,$(local_src))

libraries  += $(local_lib)
sources    += $(local_src)

$(local_lib): $(local_objs)
        $(AR) $(ARFLAGS) $@ $^
```

</div>

</div>

[]{#iddle1500 .indexterm}Thus, all the information specific to a module
is contained in an include file in the module directory itself. The
top-level [*makefile*]{.emphasis} contains only a list of modules and
`include`{.literal} directives. Let’s examine the
[*makefile*]{.emphasis} and [*module.mk*]{.emphasis} in detail.

Each [*module.mk*]{.emphasis} include file appends the local library
name to the variable `libraries`{.literal} and the local sources to
`sources`{.literal}. The `local_`{.literal} variables are used to hold
constant values or to avoid duplicating a computed value. Note that each
include file reuses these same `local_`{.literal} variable names.
Therefore, it uses simple variables (those assigned with `:=`{.literal})
rather than recursive ones so that builds combining multiple
[*makefile*]{.emphasis}s hold no risk of infecting the variables in each
[*makefile*]{.emphasis}. The library name and source file lists use a
relative path as discussed earlier. Finally, the include file defines a
rule for updating the local library. There is no problem with using the
`local_`{.literal} variables in this rule because the target and
prerequisite parts of a rule are immediately evaluated.

In the top-level [*makefile*]{.emphasis}, the first four lines define
the variables that accumulate each module’s specific file information.
These variables must be simple variables because each module will append
to them using the same local variable name:

[]{#pro_id00318}
``` {.programlisting}
local_src  := $(addprefix $(local_dir)/,codec.c)
...
sources    += $(local_src)
```

If a recursive variable were used for `sources`{.literal}, for instance,
the final value would simply be the last value of `local_src`{.literal}
repeated over and over. An explicit assignment is required to initialize
these simple variables, even though they are assigned null values, since
variables are recursive by default.

The next section computes the object file list, `objects`{.literal}, and
dependency file list from the `sources`{.literal} variable. These
variables are recursive because at this point in the
[*makefile*]{.emphasis} the `sources`{.literal} variable is empty. It
will not be populated until later when the include files are read. In
this [*makefile*]{.emphasis}, it is perfectly reasonable to move the
definition of these variables after the includes and change their type
to simple variables, but keeping the basic file lists (e.g.,
`sources`{.literal}, `libraries`{.literal}, `objects`{.literal})
together simplifies understanding the [*makefile*]{.emphasis} and is
generally good practice. Also, in other [*makefile*]{.emphasis}
situations, mutual references between variables require the use of
recursive variables.

Next, we handle C language include files by setting
`CPPFLAGS`{.literal}. This allows the compiler to find the headers. We
append to the `CPPFLAGS`{.literal} variable because we don’t know if the
variable is really empty; command-line options, environment variables,
or other `make`{.literal} constructs may have set it. The
`vpath`{.literal} directive allows `make`{.literal} to find the headers
stored in other directories. The `include_dirs`{.literal} variable is
used to avoid duplicating the include directory list.

Variables for `mv`{.literal}, `rm`{.literal}, and `sed`{.literal} are
defined to avoid hard coding programs into the [*makefile*]{.emphasis}.
Notice the case of variables. We are following the conventions suggested
in the `make`{.literal} manual. Variables that are internal to the
[*makefile*]{.emphasis} are lowercased; variables that might be set from
the command line are uppercased.

In the next section of the [*makefile,*]{.emphasis} things get more
interesting. We would like to begin the explicit rules with the default
target, `all`{.literal}. Unfortunately, the prerequisite for
`all`{.literal} is the variable `programs`{.literal}. This variable is
evaluated immediately, but is set by reading the module include files.
So, we must read the include files before the `all`{.literal} target is
defined. Unfortunately again, the include modules contain targets, the
first of which will be considered the default goal. To work through this
dilemma, we can specify the `all`{.literal} target with no
prerequisites, source the include files, then add the prerequisites to
`all`{.literal} later.

[]{#iddle1332 .indexterm}[]{#iddle1439 .indexterm}[]{#iddle1493
.indexterm}The remainder of the [*makefile*]{.emphasis} is already
familiar from previous examples, but how `make`{.literal} applies
implicit rules is worth noting. Our source files now reside in
subdirectories. When `make`{.literal} tries to apply the standard
`%.o: %.c`{.literal} rule, the prerequisite will be a file with a
relative path, say [*lib/ui/ui.c*]{.emphasis}. `make`{.literal} will
automatically propagate that relative path to the target file and
attempt to update [*lib/ui/ui.o*]{.emphasis}. Thus, `make`{.literal}
automagically does the Right Thing.

There is one final glitch. Although `make`{.literal} is handling paths
correctly, not all the tools used by the [*makefile*]{.emphasis} are. In
particular, when using `gcc`{.literal}, the generated dependency file
does not include the relative path to the target object file. That is,
the output of `gcc -M`{.literal} is:

[]{#pro_id00319}
``` {.programlisting}
ui.o: lib/ui/ui.c include/ui/ui.h lib/db/playlist.h
```

rather than what we expect:

[]{#pro_id00320}
``` {.programlisting}
lib/ui/ui.o: lib/ui/ui.c include/ui/ui.h lib/db/playlist.h
```

This disrupts the handling of header file prerequisites. To fix this
problem we can alter the `sed`{.literal} command to add relative path
information:

[]{#pro_id00321}
``` {.programlisting}
$(SED) 's,\($(notdir $*)\.o\) *:,$(dir $@)\1 $@: ,'
```

Tweaking the [*makefile*]{.emphasis} to handle the quirks of various
tools is a normal part of using `make`{.literal}. Portable
[*makefile*]{.emphasis}s are often very complex due to vagarities of the
diverse set of tools they are forced to rely upon.

We now have a decent nonrecursive [*makefile*]{.emphasis}, but there are
maintenance problems. The [*module.mk*]{.emphasis} include files are
largely similar. A change to one will likely involve a change to all of
them. For small projects like our mp3 player it is annoying. For large
projects with several hundred include files it can be fatal. By using
consistent variable names and regularizing the contents of the include
files, we position ourselves nicely to cure these ills. Here is the
[*lib/codec*]{.emphasis} include file after refactoring:

[]{#pro_id00322}
``` {.programlisting}
local_src := $(wildcard $(subdirectory)/*.c)

$(eval $(call make-library, $(subdirectory)/libcodec.a, $(local_src)))
```

Instead of specifying source files by name, we assume we want to rebuild
all [*.c*]{.emphasis} files in the directory. The
`make-library`{.literal} function now performs the bulk of the tasks for
an include file. This function is defined at the top of our project
[*makefile*]{.emphasis} as:

[]{#pro_id00323}
``` {.programlisting}
# $(call make-library, library-name, source-file-list)
define make-library
  libraries += $1
  sources   += $2

  $1: $(call source-to-object,$2)
    $(AR) $(ARFLAGS) $$@ $$^
endef
```

The function appends the library and sources to their respective
variables, then defines the explicit rule to build the library. Notice
how the automatic variables use []{#iddle1215 .indexterm}[]{#iddle1327
.indexterm}[]{#iddle1343 .indexterm}[]{#iddle1363
.indexterm}[]{#iddle1391 .indexterm}[]{#iddle1674 .indexterm}two dollar
signs to defer actual evaluation of the `$@`{.literal} and
`$^`{.literal} until the rule is fired. The `source-to-object`{.literal}
function translates a list of source files to their corresponding object
files:

[]{#pro_id00324}
``` {.programlisting}
source-to-object = $(subst .c,.o,$(filter %.c,$1)) \
                   $(subst .y,.o,$(filter %.y,$1)) \
                   $(subst .l,.o,$(filter %.l,$1))
```

In our previous version of the [*makefile*]{.emphasis}, we glossed over
the fact that the actual parser and scanner source files are
[*playlist.y*]{.emphasis} and [*scanner.l*]{.emphasis}. Instead, we
listed the source files as the generated [*.c*]{.emphasis} versions.
This forced us to list them explicitly and to include an extra variable,
`extra_clean`{.literal}. We’ve fixed that issue here by allowing the
`sources`{.literal} variable to include [*.y*]{.emphasis} and
[*.l*]{.emphasis} files directly and letting the
`source-to-object`{.literal} function do the work of translating them.

In addition to modifying `source-to-object`{.literal}, we need another
function to compute the `yacc`{.literal} and `lex`{.literal} output
files so the `clean`{.literal} target can perform proper clean up. The
`generated-source`{.literal} function simply accepts a list of sources
and produces a list of intermediate files as output:

[]{#pro_id00325}
``` {.programlisting}
# $(call generated-source, source-file-list)
generated-source = $(subst .y,.c,$(filter %.y,$1)) \
                   $(subst .y,.h,$(filter %.y,$1)) \
                   $(subst .l,.c,$(filter %.l,$1))
```

Our other helper function, `subdirectory`{.literal}, allows us to omit
the variable `local_dir`{.literal}.

[]{#pro_id00326}
``` {.programlisting}
subdirectory = $(patsubst %/makefile,%,                         \
                 $(word                                         \
                   $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))
```

As noted in the section [String
Functions](ch04.html#string_functions "String Functions"){.xref} in
[Chapter 4](ch04.html "Chapter 4. Functions"){.xref}, we can retrieve
the name of the current [*makefile*]{.emphasis} from
`MAKEFILE_LIST`{.literal}. Using a simple `patsubst`{.literal}, we can
extract the relative path from the top-level [*makefile*]{.emphasis}.
This eliminates another variable and reduces the differences between
include files.

Our final optimization (at least for this example), uses
`wildcard`{.literal} to acquire the source file list. This works well in
most environments where the source tree is kept clean. However, I have
worked on projects where this is not the case. Old code was kept in the
source tree “just in case.” This entailed real costs in terms of
programmer time and anguish since old, dead code was maintained when it
was found by global search and replace and new programmers (or old ones
not familiar with a module) attempted to compile or debug code that was
never used. If you are using a modern source code control system, such
as CVS, keeping dead code in the source tree is unnecessary (since it
resides in the repository) and using `wildcard`{.literal} becomes
feasible.

The `include`{.literal} directives can also be optimzed:

[]{#pro_id00327}
``` {.programlisting}
modules := lib/codec lib/db lib/ui app/player
 . . .
include $(addsuffix /module.mk,$(modules))
```

[]{#iddle1290 .indexterm}[]{#iddle1499 .indexterm}For larger projects,
even this can be a maintenance problem as the list of modules grows to
the hundreds or thousands. Under these circumstances, it might be
preferable to define `modules`{.literal} as a `find`{.literal} command:

[]{#pro_id00328}
``` {.programlisting}
modules := $(subst /module.mk,,$(shell find . -name module.mk))
 . . .
include $(addsuffix /module.mk,$(modules))
```

We strip the filename from the `find`{.literal} output so the
`modules`{.literal} variable is more generally useful as the list of
modules. If that isn’t necessary, then, of course, we would omit the
`subst`{.literal} and `addsuffix`{.literal} and simply save the output
of `find`{.literal} in `modules`{.literal}.
[Example 6-3](ch06.html#nonrecursive_makefilecomma_version_2 "Example 6-3. A nonrecursive makefile, version 2"){.xref}
shows the final [*makefile*]{.emphasis}.

<div class="example">

[]{#nonrecursive_makefilecomma_version_2}
<div class="example-title">

Example 6-3. A nonrecursive makefile, version 2

</div>

<div class="example-contents">

``` {.programlisting}
# $(call source-to-object, source-file-list)
source-to-object = $(subst .c,.o,$(filter %.c,$1)) \
                   $(subst .y,.o,$(filter %.y,$1)) \
                   $(subst .l,.o,$(filter %.l,$1))

# $(subdirectory)
subdirectory = $(patsubst %/module.mk,%,                        \
                 $(word                                         \
                   $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))

# $(call make-library, library-name, source-file-list)
define make-library
  libraries += $1
  sources   += $2

  $1: $(call source-to-object,$2)
        $(AR) $(ARFLAGS) $$@ $$^
endef

# $(call generated-source, source-file-list)
generated-source = $(subst .y,.c,$(filter %.y,$1))      \
                   $(subst .y,.h,$(filter %.y,$1))      \
                   $(subst .l,.c,$(filter %.l,$1))

# Collect information from each module in these four variables.
# Initialize them here as simple variables.
modules      := lib/codec lib/db lib/ui app/player
programs     :=
libraries    :=
sources      :=

objects      =  $(call source-to-object,$(sources))
dependencies =  $(subst .o,.d,$(objects))

include_dirs := lib include
CPPFLAGS     += $(addprefix -I ,$(include_dirs))
vpath %.h $(include_dirs)

MV  := mv -f
RM  := rm -f
SED := sed

all:

include $(addsuffix /module.mk,$(modules))

.PHONY: all
all: $(programs)

.PHONY: libraries
libraries: $(libraries)

.PHONY: clean
clean:
        $(RM) $(objects) $(programs) $(libraries) $(dependencies)       \
              $(call generated-source, $(sources))

ifneq "$(MAKECMDGOALS)" "clean"
  include $(dependencies)
endif

%.c %.h: %.y
        $(YACC.y) --defines $<
        $(MV) y.tab.c $*.c
        $(MV) y.tab.h $*.h

%.d: %.c
        $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -M $< | \
        $(SED) 's,\($(notdir $*)\.o\) *:,$(dir $@)\1 $@: ,' > $@.tmp
        $(MV) $@.tmp $@
```

</div>

</div>

Using one include file per module is quite workable and has some
advantages, but I’m not convinced it is worth doing. My own experience
with a large Java project indicates that a single top-level
[*makefile*]{.emphasis}, effectively inserting all the
[*module.mk*]{.emphasis} files directly into the
[*makefile*]{.emphasis}, provides a reasonable solution. This project
included 997 separate modules, about two dozen libraries, and half a
dozen applications. There were several [*makefile*]{.emphasis}s for
disjoint sets of code. These [*makefile*]{.emphasis}s were roughly 2,500
lines long. A common include file containing global variables,
user-defined functions, and pattern rules was another 2,500 lines.

Whether you choose a single [*makefile*]{.emphasis} or break out module
information into include files, the nonrecursive `make`{.literal}
solution is a viable approach to building large projects. It also solves
many traditional problems found in the recursive `make`{.literal}
approach. The only drawback I’m aware of is the paradigm shift required
for developers used to recursive `make`{.literal}.

</div>

<div class="sect1" title="Components of Large Systems">

<div class="titlepage">

<div>

<div>

Components of Large Systems {#components_of_large_systems .title style="clear: both"}
---------------------------

</div>

</div>

</div>

[]{#iddle1145 .indexterm}[]{#iddle1206 .indexterm}[]{#iddle1207
.indexterm}[]{#iddle1299 .indexterm}For the purposes of this discussion,
there are two styles of development popular today: the free software
model and the commercial development model.

In the free software model, each developer is largely on his own. A
project has a [*makefile*]{.emphasis} and a [*README*]{.emphasis} and
developers are expected to figure it out with only a small amount of
help. The principals of the project want things to work well and want to
receive contributions from a large community, but they are mostly
interested in contributions from the skilled and well-motivated. This is
not a criticism. In this point of view, software should be written well,
and not necessarily to a schedule.

In the commercial development model, developers come in a wide variety
of skill levels and all of them must be able to develop software to
contribute to the bottom line. Any developer who can’t figure out how to
do their job is wasting money. If the system doesn’t compile or run
properly, the development team as a whole may be idle, the most
expensive possible scenario. To handle these issues, the development
process is managed by an engineering support team that coordinates the
build process, configuration of software tools, coordination of new
development and maintenance work, and the management of releases. In
this environment, efficiency concerns dominate the process.

It is the commercial development model that tends to create elaborate
build systems. The primary reason for this is pressure to reduce the
cost of software development by increasing programmer efficiency. This,
in turn, should lead to increased profit. It is this model that requires
the most support from `make`{.literal}. Nevertheless, the techniques we
discuss here apply to the free software model as well when their
requirements demand it.

This section contains a lot of high-level information with very few
specifics and no examples. That’s because so much depends on the
language and operating environment used. In
[Chapter 8](ch08.html "Chapter 8. C and C++"){.xref} and
[Chapter 9](ch09.html "Chapter 9. Java"){.xref}, I will provide specific
examples of how to implement many of these features.

<div class="sect2" title="Requirements">

<div class="titlepage">

<div>

<div>

### Requirements {#requirements .title}

</div>

</div>

</div>

Of course requirements vary with every project and every work
environment. Here we cover a wide range that are often considered
important in many commercial development environments.

The most common feature desired by development teams is the separation
of source code from binary code. That is, the object files generated
from a compile should be []{#iddle1064 .indexterm}placed in a separate
binary tree. This, in turn, allows many other features to be added.
Separate binary trees offer many advantages:

<div class="itemizedlist">

-   It is easier to manage disk resources when the location of large
    binary trees can be specified.

-   Many versions of a binary tree can be managed in parallel. For
    instance, a single source tree may have optimized, debug, and
    profiling binary versions available.

-   Multiple platforms can be supported simultaneously. A properly
    implemented source tree can be used to compile binaries for many
    platforms in parallel.

-   Developers can check out partial source trees and have the build
    system automatically “fill in” the missing files from a reference
    source and binary trees. This doesn’t strictly require separating
    source and binary, but without the separation it is more likely that
    developer build systems would get confused about where binaries
    should be found.

-   Source trees can be protected with read-only access. This provides
    added assurance that the builds reflect the source code in the
    repository.

-   Some targets, such as `clean`{.literal}, can be implemented
    trivially (and will execute dramatically faster) if a tree can be
    treated as a single unit rather than searching the tree for files to
    operate on.

</div>

Most of the above points are themselves important build features and may
be project requirements.

Being able to maintain reference builds of a project is often an
important system feature. The idea is that a clean check-out and build
of the source is performed nightly, typically by a `cron`{.literal} job.
Since the resulting source and binary trees are unmodified with respect
to the CVS source, I refer to these as reference source and binary
trees. The resulting trees have many uses.

First, a reference source tree can be used by programmers and managers
who need to look at the source. This may seem trivial, but when the
number of files and releases grows it can be unwieldy or unreasonable to
expect someone to check-out the source just to examine a single file.
Also, while CVS repository browsing tools are common, they do not
typically provide for easy searching of the entire source tree. For
this, tags tables or even `find`{.literal}/`grep`{.literal} (or
`grep -R`{.literal}) are more appropriate.

Second, and most importantly, a reference binary tree indicates that the
source builds cleanly. When developers begin each morning, they know if
the system is broken or whole. If a batch-oriented testing framework is
in place, the clean build can be used to run automated tests. Each day
developers can examine the test report to determine the health of the
system without wasting time running the tests themselves. The cost
savings is compounded if a developer has only a modified version of the
source because he avoids spending additional time performing a clean
check-out and build. Finally, the reference build can be run by
developers to test and compare the functionality of specific components.

[]{#iddle1061 .indexterm}[]{#iddle1287 .indexterm}The reference build
can be used in other ways as well. For projects that consist of many
libraries, the precompiled libraries from the nightly build can be used
by programmers to link their own application with those libraries they
are not modifying. This allows them to shorten their develoment cycle by
omiting large portions of the source tree from their local compiles. Of
course, easy access to the project source on a local file server is
convenient if developers need to examine the code and do not have a
complete checked out source tree.

With so many different uses, it becomes more important to verify the
integrity of the reference source and binary trees. One simple and
effective way to improve reliability is to make the source tree
read-only. Thus, it is guaranteed that the reference source files
accurately reflect the state of the repository at the time of check out.
Doing this can require special care, because many different aspects of
the build may attempt to causally write to the source tree. Especially
when generating source code or writing temporary files. Making the
source tree read-only also prevents casual users from accidentally
corrupting the source tree, a most common occurrence.

Another common requirement of the project build system is the ability to
easily handle different compilation, linking, and deployment
configurations. The build system typically must be able to manage
different versions of the project (which may be branches of the source
repository).

Most large projects rely on significant third-party software, either in
the form of linkable libraries or tools. If there are no other tools to
manage configurations of the software (and often there are not), using
the [*makefile*]{.emphasis} and build system to manage this is often a
reasonable choice.

Finally, when software is released to a customer, it is often repackaged
from its development form. This can be as complex as constructing a
[*setup.exe*]{.emphasis} file for Windows or as simple as formatting an
HTML file and bundling it with a jar. Sometimes this installer build
operation is combined with the normal build process. I prefer to keep
the build and the install generation as two separate stages because they
seem to use radically different processes. In any case, it is likely
that both of these operations will have an impact on the build system.

</div>

</div>

<div class="sect1" title="Filesystem Layout">

<div class="titlepage">

<div>

<div>

Filesystem Layout {#filesystem_layout .title style="clear: both"}
-----------------

</div>

</div>

</div>

Once you choose to support fmultiple binary trees, the question of
filesystem layout arises. In environments that require multiple binary
trees, there are often [*a lot*]{.emphasis} of binary trees. To keep all
these trees straight requires some thought.

A common way to organize this data is to designate a large disk for a
binary tree “farm.” At (or near) the top level of this disk is one
directory for each binary tree. []{#iddle1611 .indexterm}One reasonable
layout for these trees is to include in each directory name the vendor,
hardware platform, operating system, and build parameters of the binary
tree:

[]{#pro_id00329}
``` {.programlisting}
$ ls
hp-386-windows-optimized
hp-386-windows-debug
sgi-irix-optimzed
sgi-irix-debug
sun-solaris8-profiled
sun-solaris8-debug
```

When builds from many different times must be kept, it is usually best
to include a date stamp (and even a timestamp) in the directory name.
The format `yymmdd`{.literal} or `yymmddhhmm`{.literal} sorts well:

[]{#pro_id00330}
``` {.programlisting}
$ ls
hp-386-windows-optimized-040123
hp-386-windows-debug-040123
sgi-irix-optimzed-040127
sgi-irix-debug-040127
sun-solaris8-profiled-040127
sun-solaris8-debug-040127
```

Of course, the order of these filename components is up to your site.
The top-level directory of these trees is a good place to hold the
[*makefile*]{.emphasis} and testing logs.

This layout is appropriate for storing many parallel developer builds.
If a development team makes “releases,” possibly for internal customers,
you can consider adding an additional release farm, structured as a set
of products, each of which may have a version number and timestamp as
shown in
[Figure 6-2](ch06.html#example_of_a_release_tree_layout "Figure 6-2. Example of a release tree layout"){.xref}.

<div class="figure">

[]{#example_of_a_release_tree_layout}
<div class="figure-contents">

<div class="mediaobject">

[]{#med_id00006}![Example of a release tree
layout](/library/view/managing-projects-with/0596006101/figs/web/06fig02.png.jpg){width="311"
height="387"}

</div>

</div>

<div class="figure-title">

Figure 6-2. Example of a release tree layout

</div>

</div>

Here products might be libraries that are the output of a development
team for use by other developers. Of course, they may also be products
in the traditional sense.

[]{#iddle1076 .indexterm}[]{#iddle1078 .indexterm}Whatever your file
layout or environment, many of the same criteria govern the
implementation. It must be easy to identify each tree. Cleanup should be
fast and obvious. It is useful to make it easy to move trees around and
archive trees. In addition, the filesystem layout should closely match
the process structure of the organization. This makes it easy for
nonprogrammers such as managers, quality assurance, and technical
publications to navigate the tree farm.

</div>

<div class="sect1" title="Automating Builds and Testing">

<div class="titlepage">

<div>

<div>

Automating Builds and Testing {#automating_builds_and_testing .title style="clear: both"}
-----------------------------

</div>

</div>

</div>

It is typically important to be able to automate the build process as
much as possible. This allows reference tree builds to be performed at
night, saving developer time during the day. It also allows developers
themselves to run builds on their own machines unattended.

For software that is “in production,” there are often many outstanding
requests for builds of different versions of different products. For the
person in charge of satisfying these requests, the ability to fire off
several builds and “walk away” is often critical to maintaining sanity
and satisfying requests.

Automated testing presents its own issues. Many nongraphical
applications can use simple scripting to manage the testing process. The
GNU tool `dejaGnu`{.literal} can also be used to test nongraphical
utilities that require interaction. Of course, testing frameworks like
JUnit ([*<http://www.junit.org>*]{.emphasis}) also provide support for
nongraphical unit testing.

Testing of graphical applications presents special problems. For
X11-based systems, I have successfully performed unattended, cron-based
testing using the virtual frame buffer, `Xvfb`{.literal}. On Windows, I
have not found a satisfactory solution to unattended testing. All
approaches rely on leaving the testing account logged in and the screen
unlocked.

</div>

<div class="footnotes" type="footnotes">

\

------------------------------------------------------------------------

<div id="ftn.ch06fn01" class="footnote">

^\[[12](#ch06fn01){.para}\]^ Miller, P.A., [*Recursive Make Considered
Harmful*]{.emphasis}, AUUGN Journal of AUUG Inc., 19(1), pp. 14–25
(1998). Also available from
[*<http://aegis.sourceforge.net/auug97.pdf>*]{.emphasis}.

</div>

</div>

</div>

</div>

<div
class="section t-bottom-cta bottom-cta bottom-cta-book free-chapter">

Get *Managing Projects with GNU Make, 3rd Edition* now with O’Reilly
[online learning.]{.nowrap}

O’Reilly members experience live online training, plus books, videos,
and digital content from [200+ publishers.]{.nowrap}

<div class="controls">

[Start your free
trial](https://learning.oreilly.com/p/register/){.button-primary}

</div>

</div>

</div>

</div>

</div>

<div class="content">

<div class="footer-main" aria-label="company info">

<div class="footer-mainLeft">

<div class="footer-mainLeftOne">

<div class="footer-approach">

[About O’Reilly](https://www.oreilly.com/about/) {#about-oreilly .footer-header}
------------------------------------------------

-   [Teach/write/train](https://www.oreilly.com/work-with-us.html)
-   [Careers](https://www.oreilly.com/careers/)
-   [Community partners](https://www.oreilly.com/partner/signup.csp)
-   [Affiliate program](https://www.oreilly.com/affiliates/)
-   [Submit an RFP](https://www.oreilly.com/online-learning/rfp.html)
-   [Diversity](https://www.oreilly.com/diversity/)
-   [O’Reilly for
    marketers](https://www.oreilly.com/content-marketing-solutions.html){#footerSponsorshipLink}

</div>

</div>

<div class="footer-mainLeftTwo">

<div class="footer-contact">

[Support](https://www.oreilly.com/online-learning/support/) {#support .footer-header}
-----------------------------------------------------------

-   [Contact us](https://www.oreilly.com/about/contact.html)
-   [Newsletters](https://www.oreilly.com/emails/newsletters/)
-   [Privacy policy](https://www.oreilly.com/privacy.html)

facebook-logo
linkedin-logo
youtube-logo

</div>

</div>

</div>

<div id="download-info" class="footer-download">

Download the O’Reilly App {#download-the-oreilly-app .footer-header}
-------------------------

Take O’Reilly online learning with you and learn anywhere, anytime on
your phone [and tablet.]{.nowrap}

<div class="footer-downloadLinks">

[![Apple app
store](https://cdn.oreillystatic.com/oreilly/images/app-store-logo.png)](https://itunes.apple.com/us/app/safari-to-go/id881697395)
[![Google play
store](https://cdn.oreillystatic.com/oreilly/images/google-play-logo.png)](https://play.google.com/store/apps/details?id=com.safariflow.queue)

</div>

</div>

<div id="tv-info" class="footer-download">

Watch on your big screen {#watch-on-your-big-screen .footer-header}
------------------------

View all O’Reilly videos, Superstream events, and Meet the Expert
sessions on your [home TV.]{.nowrap}

<div class="footer-downloadLinks">

[![Roku Payers and
TVs](https://cdn.oreillystatic.com/oreilly/images/roku-tv-logo.png)](https://channelstore.roku.com/details/c8a2d0096693eb9455f6ac165003ee06/oreilly)
[![Amazon
appstore](https://cdn.oreillystatic.com/oreilly/images/amazon-appstore-logo.png)](https://www.amazon.com/OReilly-Media-Inc/dp/B087YYHL5C/ref=sr_1_2?dchild=1&keywords=oreilly&qid=1604964116&s=mobile-apps&sr=1-2)

</div>

</div>

<div id="donotsell-info" class="footer-donotsell">

Do not sell my personal information {#do-not-sell-my-personal-information .footer-header}
-----------------------------------

Exercise your consumer rights by contacting us at
[donotsell@oreilly.com](mailto:donotsell@oreilly.com?subject=Do%20Not%20Sell%20My%20Personal%20Information%20Request).

</div>

</div>

<div class="footer-subfooter">

[![O'Reilly
home](https://cdn.oreillystatic.com/images/sitewide-headers/oreilly_logo_mark_red.svg){#footer-subfooterLogo
.footer-subfooterLogo}](https://www.oreilly.com "home page")
© 2021, O’Reilly Media, Inc. All trademarks and registered trademarks
appearing on oreilly.com are the property of their respective owners.

[Terms of service](https://www.oreilly.com/terms/) • [Privacy
policy](https://www.oreilly.com/privacy.html) • [Editorial
independence](https://www.oreilly.com/about/editorial_independence.html)

</div>

</div>
