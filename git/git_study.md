# GIT


Table of Contents
==========================

<!-- vim-markdown-toc GFM -->

* [Git locally](#git-locally)
* [Branch out](#branch-out)
* [Merge branches](#merge-branches)
* [Git remote](#git-remote)
* [Git config list](#git-config-list)
* [Misc](#misc)
* [Discard local change](#discard-local-change)
* [Git rm](#git-rm)
* [Generial Config within .gitconfig](#generial-config-within-gitconfig)
* [Removing a file added in the most recent unpushed commit](#removing-a-file-added-in-the-most-recent-unpushed-commit)
* [Removing sensitive data from a repository](#removing-sensitive-data-from-a-repository)
* [how can i clean .git folder](#how-can-i-clean-git-folder)
* [Reference](#reference)

<!-- vim-markdown-toc -->

## Git locally
- `git init`                : create repo at local directory
- `git add file_name`       : add file_name to repo
- `git commiti -m "msg"`    : commit with comments

## Branch out
- `git branch br_name`      : create "br_name" beside "master"
- `git checkout br_name`    : go to brance of br_name

## Merge branches
- `git checkout master`     : go to "master"
- `git merge br_name`       : merge br_name with master, may occur conflicts

## Git remote
- `git remote add origin ssh://usr@server:port/dir`
- `git push -u origin master`

## Git config list
- `git config --list`
    
## Misc
- `git add` must before `git commit`

## Discard local change
- `git checkout file`   just discard one file
- `git reset --hard`   discard all local file
- `git stash`   discard all local changes, but save them for possible re-use later

## Git rm

* remove the file from the Git repository and the filesystem
    - `git rm file1.txt`
    - `git commit -m "remove file1.txt"`
* remove the file ONLY from the Git repository and not remove it from the filesystem
    - `git rm --cached file1.txt`
    - `git commit -m "remove file1.txt"`

And then , push changes to remote repo 
    `git push origin brance_name`

## Generial Config within .gitconfig
  ```
  [user]
    email = xxx@xxx 
    name = xxx
  [alias]
	co = checkout
	br = branch
	ci = commit -a -m
	st = status -s
	unstag = reset HEAD --
	last = log -1 HEAD
	psh = push origin master
  ```

## [Removing a file added in the most recent unpushed commit](https://docs.github.com/en/free-pro-team@latest/github/managing-large-files/removing-files-from-a-repositorys-history)


1. Open Terminal.
2. Change the current working directory to your local repository.
3. To remove the file, enter `git rm --cached`:
```
    $ git rm --cached giant_file
    # Stage our giant file for removal, but leave it on disk
```
4. Commit this change using --amend -CHEAD:
```
    $ git commit --amend -CHEAD
    # Amend the previous commit with your change
    # Simply making a new commit won't work, as you need
    # to remove the file from the unpushed history as well
```
5. Push your commits to GitHub:
```
    $ git push
    # Push our rewritten, smaller commit
```

## [Removing sensitive data from a repository](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/removing-sensitive-data-from-a-repository)

`git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch fixtures/11_user_answer.json' HEAD`

`git push origin --force --all`

`git filter-branch -f --tree-filter 'rm -rf xxx' HEAD` will remove "my_file" from every commit.

## [how can i clean .git folder](https://stackoverflow.com/questions/5277467/how-can-i-clean-my-git-folder-cleaned-up-my-project-directory-but-git-is-sti)

`git gc --aggressive --prune`

## [put links in code blocks on github](https://gist.github.com/jesstelford/cb4dd6fafc18221ce27250e84fd19327)

```
<pre>
<a href="hyperlink">title</a>
<b> bold font </b>
</pre>
```

## Reference
- [Git for beginners: The definitive practical guide](https://stackoverflow.com/questions/315911/git-for-beginners-the-definitive-practical-guide)

- [How To Set Up a Private Git Server on a VPS](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-git-server-on-a-vps)
    ```sh
    git init --bare git_name.git
    ```
