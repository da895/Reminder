Jobserver Implementation 
========================

June 16th, 2003    (updated September 26th, 2015)


This paper describes the GNU make “jobserver” implementation: it is
meant mainly for people who want to understand the GNU make jobserver,
but also for those interesting in a traditionally hairy problem in UNIX
programming: how to wait for two different types of events (signals and
file descriptors) at the same time.

Job-whatsis now?
----------------

GNU make, as I assume you know if you’re reading this, is the GNU
implementation of the venerable make program which controls and directs
the rebuilding of programs from source in the most efficient way
possible. GNU make has a capability not found in too many other
implementations of make: it can invoke multiple commands, or “jobs”, in
parallel. When GNU make can determine that two commands are completely
independent of each other (and when the user has requested it), GNU make
will invoke them both at the same time. There are basically three types
of parallelism available in GNU make: none (each job is executed
serially so that the previous job must complete before the next begins),
infinite (GNU make invokes as many jobs as are possible, given the
prerequisite information in the makefile), and “at most N”, where GNU
make will invoke between 1 and N jobs, but never more than N.

It’s this last type of parallelism that is the most common, for users
who use parallelism at all, and it is that type at which the jobserver
feature is directed.

What’s the point?
-----------------

Before we can understand what jobserver is, we need to understand the
problem it’s designed to solve. If you consider a simple program with
one directory, one makefile, and one instance of make to process it,
then it’s easy to see that the GNU make program can always know how many
jobs it has outstanding at any given time, and so it can always ensure
that as many jobs as possible are running at the same time, without
exceeding the limit of N jobs. However, very few programs these days are
simple enough to fit into a single directory. Most have a number of
subdirectories as well. And most make environments, despite compelling
arguments against it, use a traditional recursive build style where a
makefile in the toplevel directory invokes a new make in each
subdirectory, and those subdirectory makefiles may themselves invoke
more sub-makes again in *their* subdirectories.

In this recursive environment, we can see that no one instance of GNU
make has enough information, enough “global vision”, to be able to know
how many jobs are being run at any given moment across all the other
instances of make. So, GNU make implemented parallelism in a sub-optimal
way when recursion was involved: the top-level GNU make would implement
parallelism as best as it could, but all the sub-make programs would run
all their jobs serially. This ensured that no more than N jobs were
running, but it also led to a great deal ofinefficiency where very often
*fewer* (often much fewer) than N jobs were running.

Even though this is a sub-optimal solution, a better solution was not
immediately obvious. Coordinating a number of instances of GNU make so
that only N jobs were invoked across all the different processes is a
tricky problem. Any number of solutions for communicating between these
make processes could be envisioned, and all with problems such as
complexity, non-portability, etc.

And so it stayed, up until GNU make version 3.78 was released in
September 1999, when the jobserver feature was added to GNU make.

It all started …
----------------

In February of 1999, Howard Chu &lt;hyc@highlandsun.com&gt; sent me a
patch with the basic idea of the jobserver. Rather than using complex
schemes such as a central server, shared memory, sockets, etc. for
synchronizing the various instances of make, he suggested we use the
simplest, most basic UNIX construct: a pipe. Not only is this easy, but
it’s also a relatively portable concept. Most operating systems these
days implement some sort of pipe feature, because that paradigm is so
useful.

The idea is ingeniously simple: the initial, top-level make creates a
pipe and writes N one-byte tokens into the pipe. That pipe is shared
between that make and all submakes, and any time any make wants to run a
job it first has to read a token from the pipe. Once the job is
complete, it writes the token back to the pipe. Since there are only N
tokens, you know that you will never invoke more than N jobs.

I spent some time going back and forth with Howard on implementation
details, and also convincing myself that reads and writes of one-byte
tokens to a pipe were atomic and robust. Then in July 1999 we started
hashing out the algorithm in earnest. After some weeks, I enlisted the
aid of Paul Eggert &lt;eggert@twinsun.com&gt; and Tim Magill
&lt;tim.magill@telops.gte.com&gt;, to make sure we had a wider set of
experience. Paul in particular brings an extremely wide range of
knowledge on the idiosyncrasies of various operating systems. Finally,
towards the end of July we involved Roland McGrath
&lt;roland@gnu.org&gt;, for his expertise in UNIX, POSIX, libc
implementation, and also to make sure we considered the Hurd in any
solution we came up with.

The five of us (Howard, Paul, Tim, Roland, and myself) spent a
significant portion of July and especially August of 1999 sending email
back and forth, dreaming up, testing, and discarding various
implementations until finally the “right” implementation was obtained…
although there are still issues as you’ll see below.

Jobserver Requirements
----------------------

As the development went on I evolved a list of features that I deemed
critical to the success of the implementation:

1.  The method must be conceptually simple—although some of the\
    details might be complex.
2.  The method must be absolutely reliable: it cannot lose tokens\
    (leading to deadlock) or otherwise misbehave. An unreliable make is\
    no better than no make.
3.  The method should be as portable as possible; although I did\
    not require it to work on every operating system that GNU make\
    supported, I certainly did want it to work at least on every\
    moderately modern UNIX/POSIX-like OS.

The Final Result
----------------

In brief, here is how the GNU make jobserver implementation works today.
Below I will discuss some of the more hairy details, as well as describe
some of the alternatives we considered and dismissed.

1.  The user invokes `make` with the `-j N` option, specifying parallel
    builds with at most *N* concurrent jobs.
2.  GNU make creates a pipe, and writes *N*-1 tokens into the pipe.
    -   A token is just a one-byte character.
    -   All tokens are identical.
    -   We write only *N*-1 tokens because one is considered used up by
        this top-level instance of make.
3.  The top-level GNU make constructs a special form of the `-j` option,
    which specifies the read and write file descriptors (FDs) for the
    jobserver pipe, and installs it to be passed to any sub-makes so
    they can also access the jobserver pipe.
4.  Now make processing proceeds normally, to read in makefiles and
    determine what targets need to be rebuilt.
5.  When GNU make determines that a target needs to be rebuilt, a token
    is obtained. One of these cases will hold if we are in a
    non-infinite parallel build:
    -   This instance of make has no jobs running. In this case, the job
        is started without needing a token. Each instance of make has a
        token that it was started with: that token is a “free” token
        which can always be used by that make and only that make. So,
        every recursive invocation of make can always run at least one
        job at all times.
    -   This instance of make has one or more jobs running. In this
        case, GNU make does a blocking read of one byte on the jobserver
        pipe. When it returns, usually it means we have a new token we
        can use for this job.
6.  When a job is finished, one of these cases will hold:
    -   This instance of make still has one or more jobs running. In
        this case, a one-byte token is written back to the jobserver
        pipe.
    -   This was the last job currently being executed by this make. In
        this case we don’t write a token; this represents the personal
        token owned by the make process.
7.  If the job to be run is **not** a sub-make (determined the same way
    GNU make has always done so: by the absence of both the `MAKE`
    variable in the command script and the special prefix `+` before a
    line in the command script), then GNU make will close the jobserver
    pipe file descriptors before invoking the commands. This ensures
    that no other commands will interrupt the jobserver processing, and
    it also ensures that (poorly written, but…) commands that expect
    certain file descriptors to be available will not be disappointed.

    If the makefile is not well-formed and GNU make’s heuristic for
    detecting sub-makes is not successful, then the sub-make will find
    the special form of the `-j` option. When it tries to access the
    jobserver file descriptors, it will fail since the parent has closed
    them before invoking the sub-make. In that case, GNU make generates
    an informative message and proceeds in a serial fashion (as if it
    had been invoked without `-j`).

Then it gets ugly …
-------------------

The above algorithm seems simple, but it dances around a very tricky
problem. In a normal, serial invocation GNU make will invoke a command
script, then `wait` for it to complete before proceeding with the next
command. In a parallel invocation, we usually need to wait on one of
*two* different events: either a job we already invoked completes, or a
new token is made available on the jobserver pipe.

The former event is heralded (in an asynchronous fashion, which we
require in this situation) by subscribing for, and receiving, a
`SIGCHLD` signal. The latter event, obviously, means that data is ready
to be read on a file descriptor. Unfortunately, in UNIX it is quite
difficult to write a program which can both wait for a signal and wait
for data on a file descriptor simultaneously. Solving this problem in as
portable and reliable a manner as possible is what took us all that
time: the rest of the algorithm was quite simple to write.

Here I describe how GNU make manages this, and below I discuss some
other options we considered, and discarded. Most of these are quite
respectable solutions: I decided they were not ideal for the purposes of
GNU make, which are quite specific, but they may well be the best for
other situations. The precise implementation details may be slightly
different in the current version of GNU make, but this is the general
outline of the solution:

1.  We install a signal handler for `SIGCHLD`. This signal handler will
    `close` the duplicate file descriptor created in the first step.
2.  We set the `SA_RESTART` flag on this signal handler. This ensures
    that any system calls that are in progress when the signal handler
    is invoked will be automatically restarted by the kernel. Without
    this, we would have to check every system call in GNU make to see if
    it returned `EINTR`, and restart it by hand. Given the number of
    system calls, and user library functions that invoke system calls,
    in GNU make, this is an almost impossible task. `SA_RESTART` saves
    us from that work. Or so we thought…
3.  GNU make continues on until it decides it needs to run a job. If it
    is not currently running any jobs, then it simply invokes the job
    (this is the single “free” token alloted to every make).
4.  If GNU make is already running one or more jobs and wants to invoke
    another, then we need to get a token from the jobserver pipe. This
    needs to be done very carefully to ensure that it’s reliable.
    a.  We use `dup` to create a duplicate of the *read* side of the
        jobserver pipe. Note that we might already have a duplicate file
        descriptor from a previous run: if so we don’t re-`dup` it.
    b.  We reap all child processes which have died but not been reaped.
        For each job completed, if we still have at least one
        outstanding job we write a token to the jobserver pipe to
        represent the completed job. If it is the only job we had
        invoked it represents our “free” token, so we don’t write a
        token to the pipe for that.
    c.  If we now have no jobs running, we can use the “free” token so
        we’re done.
    d.  We still need to get a token from the jobserver pipe. First we
        disable `SA_RESTART` on the `SIGCHLD` signal. This will allow
        the blocking `read` to be interrupted if a child process dies.
    e.  Then, we perform a blocking `read` of one byte on the
        *duplicate* jobserver file descriptor. This `read` could return
        in exactly one of these ways:
        **Returns 0:**
        This means someone closed the write end of the pipe. This
        actually cannot happen, because we never close the write end of
        the pipe. So we don’t worry about this.
        **Returns 1:**
        This means we actually got a token, so we now have a license to
        start a job and we’re done.
        **Returns -1, and `errno == EINTR`:**
        This means we got a `SIGCHLD`, so one of our currently running
        jobs completed. So, we go back to step 3.
        **Returns -1, and `errno == EBADF`:**
        This is the tricky one. This means that the file descriptor was
        closed, by the `SIGCHLD` signal handler so again a child has
        died and again to handle this we go back to step 3.

Obviously, the tricky bits here are the `dup` of the read file
descriptor and the signal handler. It’s critical to this algorithm that
we can *never* enter into the blocking `read` in step 4e with any
children that have died but not been reaped. If that can happen, then we
could enter a deadlock situation: because that child is outstanding, the
token that would have been freed by that child is never released.
Because the token is never released and written to the pipe, the `read`
might not return. If no other children die to interrupt the `read` with
a `SIGCHLD`, and no other instances of make exist or they enter into the
same situation and don’t write tokens back to the pipe, then deadlock
occurs. Because of certain features of the algorithm, like the “free”
token, etc. this would actually have to happen in at least two instances
of make, but it’s possible.

In the above algorithm there is a race condition: no matter how soon
after the loop to reap children in step 4b we perform the `read` in step
4e, there is a gap between the instant we check for exited child
processes and the instant we start the `read`. If a child dies in that
gap, it will not be noticed.

The tricky bits serve to fill that gap: if a child dies the `SIGCHLD`
handler will close the file descriptor. In that case, when we get to the
`read` in step 4e, it will immediately return with a `EBADF`. This tells
make that a child died after we last checked (really, after we ran the
`dup`) and before the `read` started, eliminating the race condition.

`SA_`non-`RESTART`er?
---------------------

This is all very well, but problems began to arise. After some debugging
it turns out that not all operating systems that supposedly support
`SA_RESTART` actually do support it properly. Operating systems as
common as Solaris do *not* properly restart common system calls like
`stat` upon receiving signals, even if the `SA_RESTART` flag is properly
set. This is extremely unfortunate, as the POSIX standard is fairly
clear on this point: if a system call can return with `EINTR`, then it
must implement the `SA_RESTART` semantics properly. Solaris, and a
number of other operating systems, fail to do so. GNU/Linux, I’m happy
to say, as far as I can tell does properly implement `SA_RESTART`.

Because of this I was forced to add special code back into GNU make to
handle situations where system calls might return with `EINTR`, even in
areas where I know that `SA_RESTART` will always be set. This is highly
unfortunate and, due to the difficulty I’m sure there are places which
are not properly protected. In the latest versions of GNU make I’ve done
all the obvious and common cases, but it must be admitted that until the
vendors properly implement the POSIX spec, there is an outside chance
that using GNU make’s jobserver feature will lead to unexpected behavior
on those operating systems.

Other Options
-------------

As I’ve mentioned, the above algorithm grew out of a long conversation,
with many twists and turns. It looks significantly different in the
details from the original algorithm proposed by Howard. Along the way we
examined and discarded a number of alternatives.

### Threads

Obviously one idea is to use threads. It’s common to have a separate
thread for dealing with signals and combining threads with semaphores,
etc. would allow GNU make to wait on two different types of asynchronous
events simultaneously. This was rejected because so far GNU make was
single-threaded, and requiring multi-threading was deemed too much of a
price to pay.

### Internal Pipe with `select`

Another common way to handle this problem, without threading, is to
create another, internal pipe. Each instance of GNU make will create its
own extra internal pipe, and will not share it with other processes. In
this algorithm the `SIGCHLD` signal handler will write a byte to the
internal pipe when it is invoked. Now, two different types of
asynchronous event (signals and file descriptor reads) are reduced to
one: file descriptor reads–but on different file descriptors (one for
the jobserver and one for the internal pipe). Waiting on multiple file
descriptors is quite easy with `select`. This was rejected mainly
because `select` is surprisingly difficult to use in portable code: it
has different prototypes, etc. It is also reduced portability. Also, the
internal pipe needed to be protected by making sure it was marked for
close on `exec`, and other similar complications. Also, of course, this
doesn’t solve the issues involved with `SA_RESTART` since we still need
a `SIGCHLD` signal handler. I considered the algorithm we did choose to
be simpler, more portable, and just as reliable as this one.

Copyright © 1997-2021 [Paul D. Smith](http://mad-scientist.net) ·
Verbatim copying and distribution is permitted in any medium, provided
this notice is preserved.
