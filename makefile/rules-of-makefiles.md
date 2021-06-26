Rules of Makefiles 
==================

November 2nd, 2002    (updated September 30th, 2015)

A somewhat tongue-in-cheek title, but this page lists a few very
important rules you should always keep in mind when creating makefiles.
Following these rules will allow your makefiles to be both pithy and
beautiful. And they will make maintaining and modifying them, and thus
your entire life, a much more pleasant experience.

1.  Use GNU `make`.
    Don’t hassle with writing portable makefiles, use a portable
    *`make`* instead!
2.  Every non-`.PHONY` rule **must** update a file with the *exact* name
    of its target.
    Make sure every command script touches the file “`$@`“–not
    “`../$@`“, or “`$(notdir $@)`“, but **exactly** `$@`. That way you
    and GNU `make` always agree.
3.  Life is simplest if the targets are built in the current working
    directory.
    Use `VPATH` to [locate the sources](/papers/how-not-to-use-vpath/)
    from the objects directory, not to locate the objects from the
    sources directory.
4.  Follow the Principle of Least Repetition.
    Try to never write a filename more than once. Do this through a
    combination of make variables, pattern rules, automatic variables,
    and GNU `make` functions.
5.  Every non-continued line that starts with a TAB is part of a command
    script–and vice versa.

    If a non-continued line does not begin with a TAB character, it is
    **never** part of a command script: it is always interpreted as
    `makefile` syntax. If a non-continued line does begin with a TAB
    character, it is **always** part of a command script: it is never
    interpreted as `makefile` syntax. Note this is not strictly true but
    you are best off pretending it is always true.

    Continued lines are always of the same type as their predecessor,
    regardless of what characters they start with.

6.  Don’t use directories as normal prerequisites.
    It’s virtually never correct to use a directory as a normal
    prerequisite for a target. GNU `make` treats directories as any
    other file and rebuilds the target if the modification time of the
    directory has changed. However, modification times of directories
    change whenever a file is added, removed, or renamed in that
    directory… this is almost never what you want. It is useful to list
    directories as
    [*order-only*](http://www.gnu.org/software/make/manual/html_node/Prerequisite-Types.html)
    prerequisites, however.

Yes, that’s all of them… so far. It’s not that that’s all I have to say
on the subject, but coming up with points which are both truly
fundamental and expressible in a succinct rule format, ain’t easy.

Let me know if you have suggestions.


Copyright © 1997-2021 [Paul D. Smith](http://mad-scientist.net) ·
Verbatim copying and distribution is permitted in any medium, provided
this notice is preserved.

