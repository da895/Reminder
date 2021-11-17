# Rebase Onto - When Dropping Commits Makes Sense: Git in Practice - Part 3

In a previous article, I showed you some of the [capabilities of interactive rebase](https://www.thinktecture.com/en/tools/demystifying-git-rebase). I mentioned that you can also [drop commits when rebasing](https://www.thinktecture.com/en/tools/git-interactive-rebase). In this article, I would like to demonstrate scenarios in which that makes sense and a short-cut to achieve what we want.

## Automatically Dropped Commits

Imagine the following graph:

```text
      A---B---C (feature)
     /
D---E---A---G (main)
```

As you can see, we have made change A on `feature`. Let's say we added a line to a configuration file. We can also see `main` has moved further and also introduced the same change A.

If we now rebase `feature` onto `main`, commit A of `feature` would be empty and therefore will automatically be skipped for you, resulting in a graph as such:

```text
              B'--C' (feature)
             /
D---E---A---G (main)
```

When rebasing, changes that are already in the base might result in empty commits, which git skips.



## Branching off a Feature

Sometimes, when developing a feature, you are reliant on a recently  developed addition to your codebase. Assume that the changes you need  are in a feature branch that has not been integrated into `main` yet.

What you can do in this case is to base your branch off of the feature branch you are waiting on:

```text
                        X---Y---Z (feature)
                       /
              A---B---C (feature-base)
             /
D---E---F---G---H---I (main)
```

But what do we see here? `main` has moved ahead of `feature-base`. It is not unusual for the person in charge of `feature-base` to now rebase onto main, to integrate the changes, and ready the feature for a merge:

```text
                A---B---C---X---Y---Z (feature)
               /
              /       A'--B'--C' (feature-base)
             /       /
D---E---F---G---H---I (main)
```

`feature-base` is now based on `main`, and commits A through C have been re-applied.

If the rebase of `feature-based` went smoothly without any conflicts, and we rebase `feature` onto it, we will not run into problems, and git skips the empty commits as explained above.

That is not always the case. Also, imagine `feature-base` also moved a little further and was integrated into `main` already. Either way, our goal would be to only take the commits of our `feature` branch, in this case, X, Y, and Z, to a new base.

When using interactive rebase, to rebase `feature` onto `feature-base`, we see something like this:

```text
pick 9a56133 A
pick bf1de76 B
pick 5bc89ff C
pick bebdada X
pick 4ab9db0 Y
pick 47ff725 Z
```

We now have the option to drop commits A, B, and C, by either removing the lines in the editor or changing the command to `drop`, resulting in applying commits X through Z to where we need them to be.

```text
                                X'--Y'--Z' (feature)
                               /
                      A'--B'--C' (feature-base)
                     /
D---E---F---G---H---I (main)
```

Using an interactive rebase, dropping some commits is quite simple,  even when they are in the middle of a series. If we want to omit some  commits at the beginning only, there is a shorter form built into the  rebase command.





## Rebase --onto

Let's assume to be in the same situation as before:

```text
                        X---Y---Z (feature)
                       /
              A---B---C (feature-base)
             /
D---E---F---G---H---I (main)
```

Imagine that this time, we simply want to transplant X, Y, and Z, onto `main`. Using the `rebase` command, we can achieve this by doing the following:

```text
$ git rebase --onto <base> <upstream> [<branch>]

$ git rebase --onto main feature-base feature
```

Executing the command will get us this graph:

```text
                A---B---C (feature-base)
               /
              /       X'--Y'--Z' (feature)
             /       /
D---E---F---G---H---I (main)
```

As you can see in the onto-form of the rebase command, we need to provide the `upstream` from which we want to pluck the commits.

In the above example, we still have a reference to that in the form of the `feature-base` branch. Let's look back at the situation we encountered before:

```text
                A---B---C---X---Y---Z (feature)
               /
              /       A'--B'--C' (feature-base)
             /       /
D---E---F---G---H---I (main)
```

Here, we do not have that reference.

But fear not! Instead of the upstream reference, we can just use the SHA hash of commit C. Assuming that `feature` is the current branch, the shortest form would be:

```text
$ git rebase --onto feature-base 5bc89ff
```

Now we replicated our interactive rebase from before, resulting in:

```text
                                X'--Y'--Z' (feature)
                               /
                      A'--B'--C' (feature-base)
                     /
D---E---F---G---H---I (main)
```



## Conclusion

In this article, we looked at dropping commits when rebasing and introduced the `--onto` flag, the rebase command provides. I am using this way of rebasing  frequently, so I wanted to demonstrate it here and hope that you can  benefit from it as much as I do.

Check out our [newsletter](https://www.thinktecture.com/newsletter) if you don't want to miss articles, screencasts, and webinars by our experts.