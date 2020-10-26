# GIT


<!-- vim-markdown-toc GFM -->

* [Git locally](#git-locally)
* [Branch out](#branch-out)
* [Merge branches](#merge-branches)
* [Git remote](#git-remote)
* [Git config list](#git-config-list)
* [Misc](#misc)
* [Discard local change](#discard-local-change)
* [Git stash](#git-stash)
* [Git OpenSSL SSL_read: Connection was reset, errno 10054](#git-openssl-ssl_read-connection-was-reset-errno-10054)
* [Git HTTP w/o passworld](#git-http-wo-passworld)
* [origin master vs origin/master](#origin-master-vs-originmaster)
* [Git Index](#git-index)
* [Git rm](#git-rm)
* [Git submodule](#git-submodule)
* [Generial Config within .gitconfig](#generial-config-within-gitconfig)
* [Reference](#reference)
* [How do I clone a subdirectory only of a Git repository?](#how-do-i-clone-a-subdirectory-only-of-a-git-repository)
* [How to Shrink a Git Repository](#how-to-shrink-a-git-repository)
  * [Cleaning the files](#cleaning-the-files)
  * [Push the cleaned repository](#push-the-cleaned-repository)
  * [Tell your teammates](#tell-your-teammates)
* [git拆仓(原Git库拆分子目录作为新仓库,并保留log记录)](#git拆仓原git库拆分子目录作为新仓库并保留log记录)

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
- `git reset --hard`   discard all local file ,if you want to clear the index and revert all tracked files to their state at the reset commit.
- `git reset --soft HEAD^`   if you want to purge your commit history but keep your index and filesystem unchanged.
- `git stash`   discard all local changes, but save them for possible re-use later

## Git stash

- https://git-scm.com/docs/git-stash
```
git stash
git stash list
git stash apply
git stash pop
```

## Git OpenSSL SSL_read: Connection was reset, errno 10054
- `git config --global http.sslVerfiy "false"`

## Git HTTP w/o passworld
- `git config --global credential.helper store`

if error found  as `remote: The project you were looking for could not be found or you don't have permission to view it.
fatal: repository 'xxx' not found`
- `git config credential.username "xxx"`
- `git config --global credential.username "xxx"`

## origin master vs origin/master

origin master : the branch **master** from the remote repository **origin** 
origin/master : one copy of remote repository， the local branch

## Git Index

Git Index may be defined as the staging area between the workspace and the repository. The major use of Git Index is to set up and combine all changes together before you commit them to your local repository. Let’s understand what this working workspace and local repo mean and functions before getting into deep with Git Index. Below is its pictorial representation.
![image](https://github.com/da895/Reminder/assets/36041044/2145ea89-e9f4-49bf-bee0-54e478befbae)


## Git rm

* remove the file from the Git repository and the filesystem
    - `git rm file1.txt`
    - `git commit -m "remove file1.txt"`
* remove the file ONLY from the Git repository and not remove it from the filesystem
    - `git rm --cached file1.txt`
    - `git commit -m "remove file1.txt"`

And then , push changes to remote repo 
    `git push origin brance_name`

## Git submodule

* add submodule
```
git submodule add url
git commit -m "xxx"
```

* checkout submodule
```
git submodule init
git submodule update
```
or
```
$ git submodule update --init --recursive
```
or 
```
git clone URL --recurse-submodules
```

* update a git submodule
```
$ git submodule update --remote --merge
```
* Fetch new submodule commits
```
$ cd repository/submodule 
$ git fetch
$ git log --oneline origin/master -3
93360a2 (origin/master, origin/HEAD) Second commit
88db523 First commit
43d0813 (HEAD -> master) Initial commit
$ git checkout -q 93360a2


$ cd repository

$ git add .

$ git commit -m "Added new commits from the submodule repository"

$ git push
```
  
  

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

## How to Shrink a Git Repository

### Cleaning the files

Cleaning the file will take a while, depending on how busy your  repository has been. You just need one command to begin the process:

```
git filter-branch --tag-name-filter cat --index-filter 'git rm -r --cached --ignore-unmatch filename' --prune-empty -f -- --all
```

This command is adapted from other sources—the principal addition is `--tag-name-filter cat` which ensures tags are rewritten as well.

After this command has finished executing, your repository should now be cleaned, with all branches and tags in tact. Reclaim space

While we may have rewritten the history of the repository, those  files still exist in there, stealing disk space and generally making a  nuisance of themselves. Let's nuke the bastards:

```
rm -rf .git/refs/original/

git reflog expire --expire=now --all

git gc --prune=now

git gc --aggressive --prune=now
```

Now we have a fresh, clean repository. In my case, it went from 180MB to 7MB.

### Push the cleaned repository

Now we need to push the changes back to the remote repository, so that nobody else will suffer the pain of a 180MB download.

```
git push origin --force --all
```

The `--all` argument pushes all your branches as well. That's why we needed to clone them at the start of the process.

Then push the newly-rewritten tags:

```
git push origin --force --tags
```

### Tell your teammates

Anyone else with a local clone of the repository will need to either use `git rebase`, or create a fresh clone, otherwise when they push again, those files  are going to get pushed along with it and the repository will be reset  to the state it was in before.

```html
git fetch
git reset origin/master --hard
```

## [git拆仓(原Git库拆分子目录作为新仓库,并保留log记录)](https://www.cnblogs.com/wucaiyun1/p/10955486.html)

**一.需求描述:** 
现有一个git仓库,Team A和Team B的人操作同一仓库的不同目录,Team A的dev希望Team B的dev没有权限review属于Team A的代码目录,故现需要先将这个git 库下的子目录进行拆分,为后续单git库权限独有覆盖做准备.
**二.操作背景:** 
Ubuntu shell(终端) 
**三.迁移(使用filter-branch命令)** 
由于我需要迁移的子目录包含**中文名**，因此需要使用filter-branch命令来实现迁移，当然，如果不包含中文的目录也可以使用git1.8版本以后的subtree来实现，该方法稍后说明。 

1. 首先，clone 一份原仓库并删掉原来的 remote：（依次执行以下命令） 
   （1）git clone ssh://username@xx.x.xx.xxx:29418/vendor/lenovo  
   （2）cd lenovo  
   （3）git remote rm origin  
2. 然后运行如下命令（这是重点）：  
   （1）git filter-branch --tag-name-filter cat --prune-empty --subdirectory-filter -- --all
   这条命令同样会过滤所有历史提交，只保留所有对指定子目录有影响的提交，并将该子目录设为该仓库的根目录。这里说明各下个参数的作用：
   --tag-name-filter 该参数控制我们要如何处理旧的 tag，cat 即表示原样输出；
   --prune-empty 删除空的（对子目录没有影响的）提交；
   --subdirectory-filter 指定子目录路径；
   -- --all 该参数必须跟在 -- 后面，表示对所有分支进行操作。如果你只想保存当前分支，也可以不添加此参数。
3. 清理.git的object   
   当上述命令执行完毕后，就可以看到本地的新仓库已经是原仓库子目录中的内容了，且保留了关于该子目录所有的提交历史。不过只是这样的话新仓库中的
   .git 目录里还是保存有不少无用的 object，我们需要将其清除掉以减小新仓库的体积（如果你用subtree 的方法的话是不需要执行这一步的）。
   依次执行以下命令：
   
   （1）git reset --hard  
   （2）git for-each-ref --format="%(refname)" refs/original/ |xargs -n 1 git update-ref -d  
   （3）git reflog expire --expire=now --all  
   （4）git gc --aggressive --prune=now  
   温馨提示:git gc操作耗时比较久,请耐心等待. 
5. 将新的本地仓库推送到远端   
   cd到  
   （1）添加远端地址:  
   git remote add origin  
   （2）推送到远端：  
   git push -u origin master或者git push --fore origin master  

**四.subtree方式拆仓**
**用法：** git subtree split -P [name-of-folder] -b [name-of-new-branch]  
**说明：** subtree是把一个分支拆分到另一个分支，这样的话操作起来更方便，不会改写原来分支的内容  

**举例：**  
最典型的就是Qualcomm下的AMSS部分和vendor/qcom/proprietary部分了。  
例如（包括拆仓后的push）： 

```bash
git subtree split -q -P LA.UM.9.14/LINUX/android/vendor/qcom/proprietary -b proprietary_master
git push -f ssh://gerrit.xxx.com:29418/git/android/platform/vendor/qcom/proprietary proprietary_master:sm8350_r_r1.0.c7_00001.9.377585.0_rebase_20210224

git subtree split -q -P Lahaina.LA.1.0/common -b common_master
git push -f ssh://gerrit.xxx.com:29418/git/android/AMSS/common common_master:sm8350_r_r1.0.c7_00001.9.377585.0_rebase_20210224
```


