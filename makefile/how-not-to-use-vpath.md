
How Not to Use VPATH 
====================

June 23rd, 2000    (updated September 26th, 2015)

------------------------------------------------------------------------

> One of the most common things people try to do with GNU `make` is use
> the VPATH feature for multi-architecture builds.
>
> This is certainly possible, but it isn’t nearly as straightforward as
> you might first imagine. This isn’t necessarily due to deficiencies in
> VPATH, per se, as much as a lack of understanding of what VPATH is for
> and how it works.
>
> In particular, you must take note of [Paul’s Third Rule of
> Makefiles](http://make.mad-scientist.net/papers/rules-of-makefiles/#rule3 "Rule #3")!
> This is the key. VPATH was designed to find *sources*, not *targets*.

------------------------------------------------------------------------

To try to prove this to you, we’ll walk along beside someone attempting
to create a makefile using VPATH to place targets into another directory
from the source files.
To set this up yourself, construct an environment like this:

      $ mkdir /tmp/mktest

      $ cd /tmp/mktest

      $ mkdir obj src

      $ cd src

      $ cat > foo.c
      int main() { extern int bar(); return bar(); }
      ^D

      $ cat > bar.c
      int bar() { return 0; }
      ^D

Step One
--------

The first attempt at using VPATH usually goes something like this:

      OBJDIR = ../obj

      VPATH = $(OBJDIR)

      %.o : %.c
              $(COMPILE.c) $< -o $(OBJDIR)/$@

      all: foo

      foo: foo.o bar.o
              $(LINK.o) $^ $(LDLIBS) -o $(OBJDIR)/$@

There are many things wrong with this makefile. First, note that both
the pattern rule to build `.o`'s and the explicit rule to build target
`foo` violate [Paul's Second Rule of
Makefiles](http://make.mad-scientist.net/papers/rules-of-makefiles/#rule2 "Rule #2").

Although they say "the commands I list here will create a `X` from a
file `Y`", that is *not* what the commands actually do. Instead, they
create `../obj/X` from `Y`. This is not the same thing at all, and GNU
`make` will become very upset with the deception.

So, what will happen? Well, GNU `make` will build the `.o`'s correctly,
but when it tries to build link the executable it will *think* that they
are `foo.o` and `bar.o`, not `../obj/foo.o` and `../obj/bar.o`, and so
it will invoke the linker like this:

      $ gmake
      cc -c foo.c -o ../obj/foo.o
      cc -c bar.c -o ../obj/bar.o
      cc foo.o bar.o -o ../obj/foo
      ld: foo.o: No such file or directory

The link will, of course, fail, since the `.o` files don't exist in the
current directory, but rather in `$(OBJDIR)/`.

Step Two
--------

Seeing the above error, people try to build again. The second time, it
will work:

      $ gmake
      cc ../obj/foo.o ../obj/bar.o -o ../obj/foo

Why did it work this time? Well, this time, for the first time, VPATH
actually came into play. When `make` wanted to build `foo`, it looked
for its dependencies first. Using VPATH, it was able to locate both
`../obj/foo.o` and `../obj/bar.o`, and it linked them together.

Well, it's certainly annoying that the link fails the first time. But,
this isn't the worst of the problems with this setup. Suppose you modify
`foo.c` and want to now rebuild. What will happen next depends on which
version of GNU `make` you're using; with `make` 3.75 and below you'll
get a different result, also incorrect (it will say "Nothing to be done
for 'all'"). Here we'll describe the newer GNU `make`:

      $ touch foo.c

      $ gmake -f step1.mk
      cc -c foo.c -o ../obj/foo.o
      cc foo.o obj/bar.o -o obj/foo
      ld: foo.o: No such file or directory

Argh! It broke again. Same reason as before. Once again, re-running the
make gets the link to work.

Step Three
----------

Well, that's obviously not acceptable. Once this problem is understood,
people usually try to fix their makefiles by adding `$(OBJDIR)/` at
strategic points, perhaps like this:

      OBJDIR = ../obj

      VPATH = $(OBJDIR)

      $(OBJDIR)/%.o : %.c
              $(COMPILE.c) $< -o $@

      all: foo

      foo: foo.o bar.o
              $(LINK.o) $^ $(LDLIBS) -o $(OBJDIR)/$@

The creation of `foo` is still incorrect according to the Second Rule of
Makefiles, but since nothing depends on `foo` in our example, this
incorrectness will probably go unnoticed--at least until you attempt to
create an `install` rule, perhaps.

Here the makefile wants to rely on VPATH to locate the `.o` files,
rather than prefixing them all with `$(OBJDIR)/`. A reasonable thought,
perhaps, but this is not how VPATH works.

This is what happens if we start with a clean slate:

      $ gmake
      cc -c foo.c -o foo.o
      cc -c bar.c -o bar.o
      cc foo.o bar.o -o ../obj/foo

What happened?! Well, in some sense it worked since it compiled and
linked everything OK, but it put the `.o's` in the current directory
instead of in the `$(OBJDIR)/` directory!

To understand this, first remember that `make` always builds *from the
bottom up*, not from the top down. By that I mean it finds the target it
wants to build, then looks at its dependencies, and *it's* dependencies,
etc. So far it hasn't tried to build anything. Finally, when it gets to
the bottom (no dependencies, or dependencies that can't be rebuilt), it
walks back up, attempting to build every target.

How does that explain things? Well, to build `foo`, `make` examines the
first dependency, `foo.o`. Then it tries to figure out how to build a
`foo.o`. You want it to use your new rule, but it won't, because it's
trying to build `foo.o`, **not** `$(OBJDIR)/foo.o`. So your rule doesn't
match. Instead it matches the builtin rule for building `.o`'s from
`.c`'s, and builds them in the local directory.

Step Four
---------

Now people usually throw up their hands and just add `$(OBJDIR)/` all
over the place. If they're tidy, they might try to use some of GNU
`make`'s functions to make things a little simpler to read/modify:

      PROGS   = foo
      OBJECTS = foo.o bar.o

      # Shouldn't need to change anything below here...

      OBJDIR = ../obj

      VPATH = $(OBJDIR)

      $(OBJDIR)/%.o : %.c
              $(COMPILE.c) $< -o $@

      OBJPROG = $(addprefix $(OBJDIR)/, $(PROGS))

      all: $(OBJPROG)

      $(OBJPROG): $(addprefix $(OBJDIR)/, $(OBJECTS))
              $(LINK.o) $^ $(LDLIBS) -o $@

Well! That should fix it! And indeed it does. This makefile will work
correctly in all situations. However, there's something a little strange
about it.

As written, it doesn't **need VPATH** at all! It explicitly adds the
path to all the dependencies, so VPATH is never consulted.

------------------------------------------------------------------------

Conclusion
----------

So we've shown that the only reliable way to construct a makefile that
will place targets into a remote directory, rather than the current
directory, is by prefixing all the targets with that directory path. In
other words, VPATH is useless to us for this purpose.

How depressing. Well, then, what the heck **is** VPATH good for, anyway?
As described in [Paul's Third Rule of
Makefiles](http://make.mad-scientist.net/papers/rules-of-makefiles/#rule3 "Rule #3"),
VPATH is good for finding *sources*, not for finding *targets*.

That seems impractical. After all, developers work on source files, not
target files, so requiring them to change to the target directory before
running `make` is a pain.

However, what if they didn't have to? [Click
here](http://make.mad-scientist.net/papers/multi-architecture-builds/ "Multi-Architecture Builds")
to read about a method I've used in the past for handling this common
scenario.


Copyright © 1997-2021 [Paul D. Smith](http://mad-scientist.net) ·
Verbatim copying and distribution is permitted in any medium, provided
this notice is preserved.

