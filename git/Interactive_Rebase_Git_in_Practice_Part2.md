# Interactive Rebase: Git in Practice - Part 2

Once you are comfortable with rebase, it is time to step up your game with interactive rebase. [As introduced in the previous article](https://www.thinktecture.com/en/tools/demystifying-git-rebase/), rebasing involves taking multiple commits and applying them to a base tip.

In an interactive rebase, we have a lot more control over what we  want to do with the affected commits. Some of the options include  re-ordering the commits, rewording a commit message, dropping commits,  merging several commits into a single one, and editing a past commit.





## Keeping Your History Clean

The options mentioned above are all related to organizing the git  history. While it seems very common that for some, maintaining a clean  history is not a priority, I want to make a point of how it can make our lives easier.

Committing changes to the history should not just be seen as saving a bunch of files in the current state because we feel like we haven't  done that in a while. Carefully crafted, small (or even atomic) commits  go a long way.

A well-maintained history helps a lot when tracking changes over time and makes integrating changes or moving patches around to other  branches possible. Imagine pulling a quick fix off a feature branch  quickly into production while leaving the rest untouched.

Git also has powerful functionality to perform a binary search on  commits in order to quickly determine the commit that introduced a bug  (I am referring to `git bisect`). Imagine the changes in the found commit would only touch one or two files instead of 30. You will find the bug in no time.

Therefore, I advocate for using commits and feature branches instead  of only saving your work and let your history tell the story of how a  feature came to be. It will always help in the long run and is not a lot of effort.

In the following, I want to introduce a couple of scenarios, and how to use an interactive rebase to handle them.



## Performing an Interactive Rebase

Performing an interactive rebase is no different from the standard  rebase. In the command, we tell git which branch we want to base our  branch upon:

```text
# git rebase -i <base> [<branch>]

$ git rebase -i main feature
```

As you know by now, we often rebase to update our feature branch with `main` as the new base. However, in the use cases below, our goal is mainly to manipulate the git history. Therefore, it is common to engage an  interactive rebase, even if we are already on the correct tip, like so:

```text
              A---B---C (feature)
             /
D---E---F---G (main)
```

After an interactive rebase, we might have something looking like this (assuming we changed something about commit A):

```text
              A'--B'--C' (feature)
             /
D---E---F---G (main)
```

As you can see, the graph's structure is identical, but we re-wrote the commits A through C.

So taking our example from above and assuming we have checked out the feature branch already, we can run the following:

```text
$ git rebase -i main
```

Now, the configured editor will open and present us with a list of the affected commits in the format `<command> <SHA> <commit message>` as such:

```text
pick 55cfe46 A
pick 3f32820 B
pick 74dd703 C

# Rebase 68d87a3..74dd703 onto 68d87a3 (3 commands)
```

Followed by a couple of explanations:

```text
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup <commit> = like "squash", but discard this commit's log message
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified). Use -c <commit> to reword the commit message.
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here, THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
```

Using our editor, we can now edit the lines as we desire and close it to start the interactive rebase process.





## Editing a Previous Commit

Imagine this: You just finished a feature, and you committed multiple times as the good citizen you are. Now, you feel like a method you  added three commits ago could use a comment or two, or you want to  rename a variable to improve readability. You could now make those  changes and add another commit on top. While that is great, wouldn't it  be awesome to go back in time and modify the method in the commit you  added it, so it looks like the comment or variable name was there from  the start? That's what I thought, so let me show you how. First, fire up the interactive rebase, as instructed above. You will see something  like this:

```text
pick 55cfe46 Added new API to controller
pick 3f32820 Updating model properly
pick 74dd703 Spicing up the view
```

Now the goal would be to edit the first of those commits, where we  added a method to the controller. Using your editor, you can change the  command from `pick` to `edit` so it looks like this:

```text
edit 55cfe46 Added new API to controller
pick 3f32820 Updating model properly
pick 74dd703 Spicing up the view
```

Once you close the editor, git will start applying the commits in  order like a normal rebase, but it will stop at the commit you marked  for editing.

You now have the chance to open the desired file and make your changes. Make sure to stage your changes, making use of `git add` before you continue the rebase:

```text
$ git add files
$ git rebase --continue
```

You will now also have the possibility to change the commit message if you desire to.

It is also possible that your change has caused a conflict with one  of the following commits, which you can correct accordingly. However, if you just made a trivial change, the rest of the commits should be  applied, and you have a clean history.



## Changing the Commit Message of a Previous Commit

Did you read the history of your feature branch and discovered a  disgraceful typo in your commit message? Don't worry, interactive rebase has got you covered. Start the rebase and turn your list of commits  into something like this:

```text
pick 55cfe46 Added new API to controller
reword 3f32820 Updating model properyl
pick 74dd703 Spicing up the view
```

After closing your editor, git will start applying the commits. For  every commit that you marked for rewording, you will be prompted with  the editor again, greeting you with the current message:

```text
Updating model properyl
```

Ready for you to erase your mistake from history. Just correct the  message as you see fit and close your editor for git to continue to do  its thing.

Looking at the history, it will go from

```text
              A---B---C (feature)
             /
D---E---F---G (main)
```

to

```text
              A---B'--C' (feature)
             /
D---E---F---G (main)
```

Commit A will be applied as it is and not change. As we have changed  the commit message of commit B, we have modified the commit, affecting  all commits based on it. In our case, that is only C.



## Reorder Previous Commits

If you are reading the explanation text git shows you in the first editor prompt carefully, it tells you that:

```text
# These lines can be re-ordered; they are executed from top to bottom.
```

Meaning that in your history:

```text
pick 55cfe46 A
pick 3f32820 B
pick 74dd703 C
```

You can simply change the order if you want to apply the commits. Want C before B? there you go:

```text
pick 55cfe46 A
pick 74dd703 C
pick 3f32820 B
```

Git will now apply the commits in the order given, which is useful  for handling the first case I mentioned. But it postpones cleaning up  the history.

Imagine that in C, you added just a couple of comments to the file  edited in A. Then B should not be affected by you moving C one commit  up. Now that they are right next to each other, we can put them together in a single commit. I will illustrate how to achieve that in the next  section.

But first, for illustration purposes, here you can see the graph before the rebase:

```text
              A---B---C (feature)
             /
D---E---F---G (main)
```

And here, the graph after the rebase:

```text
              A---C'--B' (feature)
             /
D---E---F---G (main)
```



## Meld Multiple Commits Into a Single One

Assuming you now have multiple commits in the history right next to  each other that you want to turn into a single commit, interactive  rebase can do that for you. In our previous example, we moved commit C  next to commit A.

Now imagine that we want the commits A and C to be in a single commit. In terms of history, we want to go from here:

```text
              A---C---B (feature)
             /
D---E---F---G (main)
```

to there:

```text
              A'---B (feature)
             /
D---E---F---G (main)
```

This process of reducing a couple commits into a single one is referred to as **squashing**. So let's squash!

Let's start the interactive rebase and take a look at our editor:

```text
pick 55cfe46 A
pick 3f32820 C
pick 74dd703 B
```

We now have two options available to us. Either way, we change the command of commit C. We want to either `squash` or `fixup` the commit.

The difference being, if we squash C into A, we are still offered to change the commit messages, which will look like this:

```text
# This is a combination of 2 commits.
# This is the 1st commit message:

A

# This is the commit message #2:

C
```

We can now use our editor to edit the commit message. Lines starting with a `#` will be ignored.

If we use `fixup` instead of squash like so:

```text
pick 55cfe46 A
fixup 3f32820 C
pick 74dd703 B
```

Git will use the commit message of A, and the process of editing the commit message is omitted.



## Conclusion

In this article, I introduced some of the things you can do with an  interactive rebase that I frequently use to keep my history nice and  tidy. I hope this serves as an introduction and motivates you to  experiment beyond my examples.

There is one more feature, namely dropping commits, which can also be very useful. I am getting into that in [the following article](https://www.thinktecture.com/en/tools/git-rebase-onto).

Check out our [newsletter](https://www.thinktecture.com/newsletter) if you don't want to miss further articles, screencasts, and webinars by our experts.