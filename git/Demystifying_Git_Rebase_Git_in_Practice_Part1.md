# Demystifying Git Rebase: Git in Practice - Part 1

Working with git  every day as our software of choice for version control, I always try to point out that familiarity with our toolset is important. The more  comfortable you are with git, the easier it will be to integrate changes and follow their history.

One highly debated functionality I use multiple times a day would be the infamous `git rebase`. In the past, I managed to make several teams comfortable with using  rebase confidently, and they do not want to miss it anymore.

You can find voices arguing against rebase that consider it harmful  or dangerous. I do feel that these statements, as many others, stem from not being familiar with what rebase does and what it can accomplish.

In this post, I want to introduce rebase, present a use case, and  discuss why it is considered dangerous by some. And why it isn't.

If you are relatively new to git, I recommend you to check out my german webinar ['Git started - verteilte Versionsverwaltung mit Git'](https://www.thinktecture.com/tools/webinar-git-versionsverwaltung/).



## What is Rebase?

Essentially, rebasing is the process of taking multiple commits and applying them on top of another base tip.

To make sense of that, we need to understand what *applying a commit* means. Without going too much into detail on how git stores its  history, we can simply imagine a commit to be the difference from the  previous commit.

Therefore, a series of commits is just a series of changes that has  been done to a certain base state. In other words, to get to the code's  current state, we take a base state and apply the changes of the series  of commits to it.

Let's try to illustrate that with a graph:

```text
      A---B---C (feature)
     /
D---E---F---G (main)
```

The capital letters represent commits. We also have two branches. One is called `feature`, pointing to the commit named C, and the other is called `main` and points to commit G.

(If you cannot follow what I mean by a branch pointing to a commit, I recommend you to check out my [git webinar in german](https://www.thinktecture.com/tools//webinar-git-versionsverwaltung/) or [this english recording](https://www.youtube.com/watch?v=S_OkNMHinlg).

Keeping things simple for the sake of explanation: the branch main refers to commits D, E, F, and G, while the branch `feature` refers to the commits A, B, and C and is based on commit E on the `main` branch.

Now when we say we want to rebase the `feature` branch onto `main`, what we are pursuing is a history that looks like this:

```text
              A'--B'--C' (feature)
             /
D---E---F---G (main)
```

This can be achieved by using the command:

```text
# git rebase <base> [<branch>]

$ git rebase main feature
```

If the currently checked out branch is `feature`, we can omit it from the command and just go with:

```text
$ git rebase main
```

Then git will checkout `feature` first and perform the rebase. But I like to remember the three-parameter-form to ensure that we rebase `<branch>` **onto** `<base>`. The base goes first, and then what we want to apply on top of it.

After a successful rebase, the branch main is the new base for our  feature branch. What happened is that the series of commits on the  branch feature (A, B, C) have been applied to a new base, G, the main  branch, thus **rebasing feature \*onto\* main**.

As you can see, I renamed the commits ABC to A'B'C'. This is because  they are not the same commit anymore. They are now commits that also  include the changes of the commits made in F and G, as the base has  moved from commit E to G.

But performing the above described rebase, our feature branch is now up to date with `main` and includes all of `main`'s changes, and that without merging `main` into our `feature` branch.



## When or Why to Rebase?

Let's first look at how we ended up in this situation:

```text
      A---B---C (feature)
     /
D---E---F---G (main)
```

Essentially, at the time the `main` branch was at commit E, we branched our `feature` branch off of that. Once we branched off E, two more commits have been added to `main`, and we added three commits to `feature`. This results in the state that our base branch is ahead of our `feature` branch.

We can see that the changes in commits F and G are not included in our `feature` branch.

Now being in the state is not an issue. We can still integrate `feature` back into `main` by a simple merge, which would result in a history like this:

```text
      A---B---C
     /         \
D---E---F---G---H (main)
```

The newly created *merge commit* H is the state that incorporates all the changes of the `feature` branch and the `main` branch. Great.

However, things do not always go like this. Imagine that while you  are developing your feature, some other feature branch has been merged  into `main` or a really important API change or feature that your branch relies on.

In that case, you want to integrate the new changes into your feature branch so you can continue your work. One way of doing that would be  merging the `main` branch into your `feature`, and then, in the end, merge your `feature` back into `main`. A graph for that situation might look like this (considering no fast-forward merge):

```text
      A---B---C---H---I---J (numbers)
     /           /         \
D---E---F-------G-----------K (main)
```

I and J denote the changes that you make after the main branch has been integrated into your feature.

But: A more elegant way would be to use rebase!

```text
              A'--B'--C'--I---J (numbers)
             /                 \
D---E---F---G-------------------K (main)
```

In this case, rebase allows us to adjust our feature branch to a  state as if we branched off of G and started our work after all the  changes we rely on are available to us.

The advantages of using rebase are that you can rebase your feature  as often as you want or need, without polluting the history. Imagine  that more changes are made to `main`, while you are still working on your `feature`. You can just update your base and have all the goodness that lies in the `main` branch ready for you to use in your `feature`.

Also, as your commits are replayed one after another, you can still  see the incremental changes that you have made. That makes resolving  conflicts easier, compared to having to fix all conflicts between the  two states you are trying to bring together all at once.

Using rebase, we can easily keep our feature branches up to date with `main`, without merging back and forth.





## Handling Conflicts When Rebasing

When applying commits to a new base state, it is possible that the  new base has made changes that are conflicting with the changes you are  trying to apply. For example, if on `main` someone edited the same file and line you did on your branch. The same  thing happens when merging. We have two conflicting states, and we want  to resolve them by changing the file to the version that incorporates  the changes correctly.

Running into a conflict when rebasing looks like this:

```text
$ git rebase master
Auto-merging file.txt
CONFLICT (content): Merge conflict in file.txt
error: could not apply 050389b... Refactoring a method
[...]
```

We now have a conflict in `file.txt`. Opening `file.txt` we will find the usual conflict markers. Either using our editor or the merge tool of our choice, we will have to resolve the conflict by  changing our file to the state we need it to be in, in our commit.

After successfully resolving all conflicts, we need to stage the file by using the `git add` command, e.g.:

```text
$ git add file.txt
```

and we can continue our rebase journey by applying all the other commits by using the command:

```text
$ git rebase --continue
```

If we do not feel comfortable resolving the conflicts and going on  with the rebase for whatever reason, we can always simple abort the  rebase and go back to before we started it by using:

```text
$ git rebase --abort
```



## The Dangers of Rebase

If you are looking into rebasing, you might find opposing opinions on its use. The more significant arguments against rebase are:

- you can mess up your code when doing it wrong
- you have to force push

Addressing the first argument, yes, obviously, your result will not  be what you expected it to be when handling the tool you are using in  the wrong way. The same can be said about misconfiguring a service.  Therefore, it is crucial to understand what we are doing, how our tools  work, and to use them properly to achieve our goals.

Most of the time, people have issues with rebase because they either  do not understand properly what it does, or they rebase the wrong way  around (like the base onto the feature). I hope my explanation above rules both of these issues out for you at  least, my dear reader (that makes us to rebase-buddies - welcome to the  club of savvy rebasers!)

Addressing the second point, the fear of force push. When rebasing a  branch, git takes the commits of that branch and applies them to the new base, resulting in a git history rewrite. If you have already pushed  your branch to a remote, there will be a disparity between your local  and the remote versions. To get the version on the remote to match  yours, you will have to force push. However, I feel that force pushing  your feature branch should never be an issue. If you are working on a  feature branch with a team member, you should communicate first, but the moment your team member fetches, they will know about your forced push  and can react accordingly. If you have not pushed your branch to a  remote yet, you will not even have to force push. Force pushing a  feature branch is completely fine, but please avoid doing so on your  main or develop branches (of course, there are exceptions to that rule,  in emergency cases) as members of your team have probably based their  work on them.

Another issue that is brought up is that "after the rebase, something broke". Here, also, the issue is not rebase. Of course, when applying  changes to another base, it is possible to run into conflicts. These  conflicts have to be resolved properly, as git cannot decide which of  the two versions of a line of code is the one that is supposed to be  correct when applying your changes. Resolving conflicts is also part of  merging, or bringing two states together and should not be a problem to  you as the author of the software you are authoring. It is part of our  collaborative efforts. I feel that resolving conflicts when rebasing is  easier, as I do not have to solve all conflicts at once, and rather  incrementally, in the way I developed my feature. Therefore I have more  contextual information on what change I did and what the correct version should look like considering the new base.



## Conclusion

We took our time to look at what a git rebase does, what issues we  can run into, and how to tackle them. I hope this explanation helps to  illustrate rebase and motivates you to incorporate it into your everyday workflow.

Stay tuned for the next article of this series in which I will show you [how to step up your game with interactive rebase](https://www.thinktecture.com/en/tools/git-interactive-rebase). [Sign up to our monthly newsletter](https://www.thinktecture.com/newsletter) and make sure not to miss more articles by our experts and me.