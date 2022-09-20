# GIT


<!-- vim-markdown-toc GFM -->

* [Git locally](#git-locally)
* [Branch out](#branch-out)
* [Merge branches](#merge-branches)
* [Git remote](#git-remote)
* [Git config list](#git-config-list)
* [Misc](#misc)
* [Discard local change](#discard-local-change)
* [Git OpenSSL SSL_read: Connection was reset, errno 10054](#git-openssl-ssl_read-connection-was-reset-errno-10054)
* [Git rm](#git-rm)
* [Generial Config within .gitconfig](#generial-config-within-gitconfig)
* [Reference](#reference)
* [How do I clone a subdirectory only of a Git repository?](#how-do-i-clone-a-subdirectory-only-of-a-git-repository)

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

## Git OpenSSL SSL_read: Connection was reset, errno 10054
- `git config --global http.sslVerfiy "false"`

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

## Reference
- [Git for beginners: The definitive practical guide](https://stackoverflow.com/questions/315911/git-for-beginners-the-definitive-practical-guide)

- [How To Set Up a Private Git Server on a VPS](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-git-server-on-a-vps)
    ```sh
    git init --bare git_name.git
    ```
    
## [How do I clone a subdirectory only of a Git repository?](https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository)

```
mkdir <repo>
cd <repo>
git init
git remote add -f origin <url>
git config core.sparseCheckout true
echo "some/dir/" >> .git/info/sparse-checkout
echo "another/sub/tree" >> .git/info/sparse-checkout
git pull origin master
//git pull --depth=1 origin master
```

