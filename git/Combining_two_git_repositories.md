# Combining two git repositories

**Use case**: You have repository A with remote location rA, and repository B (which may or may not have remote location rB). You want to do one of two things:

- preserve all commits of both repositories, but replace everything from A with the contents of B, and use rA as your remote location
- actually combine the two repositories, as if they are two branches that you want to merge, using rA as the remote location

**NB**: Check out `git subtree`/`git submodule` and [this Stack Overflow question](http://stackoverflow.com/questions/1425892/how-do-you-merge-two-git-repositories) before going through the steps below. This gist is just a record of how I solved this problem on my own one day. 

Before starting, make sure your local and remote repositories are up-to-date with all changes you need. The following steps use the general idea of changing the remote origin and renaming the local master branch of one of the repos in order to combine the two master branches.

Change the remote origin of B to that of A:
```
$ cd path/to/B
$ git remote rm origin
$ git remote add origin url_to_rA
```

Rename the local master branch of B:
```
$ git checkout master
$ git branch -m master-holder
```

Pull all the code of A from rA into your local B repo.
```
$ git fetch
$ git checkout master
$ git pull origin master
```
Now the master branch of A is *master* in B. The old master of B is *master-holder*.

Delete all the things! (i.e, scrap everything from A.) If you actually want to _merge_ both repos, this step is unnecessary.
```
$ git rm -rf *
$ git commit -m "Delete all the things."
```

Merge *master-holder* into *master*. (If you didn't do the delete step above, you have to option of `git checkout master-holder; git rebase master` instead.) For more recent versions of git, you'll probably have to add the `--allow-unrelated-histories` flag (thanks to @sadzik).
```
git merge master-holder --allow-unrelated-histories
```
`git log` should show all the commits from A, the delete commit, the merge commit, and finally all the commits from B.

Push everything to rA
```
git push origin master
```

Now your local copy of B has become a "unified" repository, which includes all the commits from A and B. rA is used as the remote repo. You no longer need your local copy of A or the remote repo rB (although keeping rB around for a bit longer isn't a bad idea).