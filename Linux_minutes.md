# Minutes about Linux Envariable

Table of Contents
=================

<!-- vim-markdown-toc GFM -->

* [[How do I resolve \`The following packages have unmet dependencies\`](https://stackoverflow.com/questions/26571326/how-do-i-resolve-the-following-packages-have-unmet-dependencies)](#how-do-i-resolve-the-following-packages-have-unmet-dependencieshttpsstackoverflowcomquestions26571326how-do-i-resolve-the-following-packages-have-unmet-dependencies)
* [How to Install Specific Version of Package using apt-get ](#how-to-install-specific-version-of-package-using-apt-get-)
* [how to check glic version on linux](#how-to-check-glic-version-on-linux)
* [ubuntu autostart for your own script](#ubuntu-autostart-for-your-own-script)
* [linux generate UUID](#linux-generate-uuid)
* [change the __File Permission__ as below](#change-the-__file-permission__-as-below)
* [SSH Passworldless Login Using SSH  Keygen in 5 Easy Steps](#ssh-passworldless-login-using-ssh--keygen-in-5-easy-steps)
* [Ubuntu User Management](#ubuntu-user-management)
  * [Where is root?](#where-is-root)
  * [Adding and Deleting Users](#adding-and-deleting-users)
  * [Use Profile Security](#use-profile-security)
  * [Password Policy](#password-policy)
* [ssh server in Ubuntu](#ssh-server-in-ubuntu)
* [Partitioning /home /moving](#partitioning-home-moving)
* [Add proxy for apt and](#add-proxy-for-apt-and)
* [List repositories on Linux](#list-repositories-on-linux)
* [sprov blog](#sprov-blog)
* [Four Spaces](#four-spaces)
* [Jerry Qu Blog](#jerry-qu-blog)
* [How to Install and Configuare VNC on Ubuntu 18.04](#how-to-install-and-configuare-vnc-on-ubuntu-1804)
* [Fix Ubuntu Chinese issue](#fix-ubuntu-chinese-issue)
* [rsync](#rsync)
* [SVN:externals](#svnexternals)
* [MSYS2](#msys2)
* [vim Markdown](#vim-markdown)
* [markdown convert to pdf within command line](#markdown-convert-to-pdf-within-command-line)
* [How to connect to Cisco AnyConnect VPN via GUI in Ubuntu 18.04](#how-to-connect-to-cisco-anyconnect-vpn-via-gui-in-ubuntu-1804)
* [Connecting to Cisco VPN from Ubuntu 18.04 without a Group Password](#connecting-to-cisco-vpn-from-ubuntu-1804-without-a-group-password)
* [linux samba](#linux-samba)
* [How do I boot directly to tty1 in ubuntu?](#how-do-i-boot-directly-to-tty1-in-ubuntu)
* [Make a Bash alias that takes a parameter](#make-a-bash-alias-that-takes-a-parameter)
* [How to unzip a multipart (spanned) ZIP on Linux](#how-to-unzip-a-multipart-spanned-zip-on-linux)
* [zip the folder and deleter the original file](#zip-the-folder-and-deleter-the-original-file)
* [NFS](#nfs)
* [Check Perl Library](#check-perl-library)
* [install perl lib via local::lib](#install-perl-lib-via-locallib)
* [9 simple ways to find the PID of a Program Running on Linux](#9-simple-ways-to-find-the-pid-of-a-program-running-on-linux)
* [High Performance & Multi-threaded SCP Using RSYNC](#high-performance--multi-threaded-scp-using-rsync)
* [copy files and directories recursively with tar](#copy-files-and-directories-recursively-with-tar)
* [DataRecovery](#datarecovery)
* [check the Linux OS](#check-the-linux-os)
* [How to find what other machines are connected to the local network](#how-to-find-what-other-machines-are-connected-to-the-local-network)
* [how can you find and replace text in a file using the Windows command_line env](#how-can-you-find-and-replace-text-in-a-file-using-the-windows-command_line-env)
* [Command Line Reference](#command-line-reference)
* [How to install RPM file on Linux](#how-to-install-rpm-file-on-linux)
* [RPM Package](#rpm-package)
* [How to download a RPM Package with all dependencies in CentOS](#how-to-download-a-rpm-package-with-all-dependencies-in-centos)
* [Need to set up yum repository for locally-mounted DVD on RHEL](#need-to-set-up-yum-repository-for-locally-mounted-dvd-on-rhel)
* [How to setup local yum reposity on CentOS 7](#how-to-setup-local-yum-reposity-on-centos-7)
* [How to setup yum reposity using locally mounted DVD](#how-to-setup-yum-reposity-using-locally-mounted-dvd)
* [Create ISO from DVD](#create-iso-from-dvd)
* [Disabling the subscription mamager repository RHEL](#disabling-the-subscription-mamager-repository-rhel)
* [ctags for systemverilog](#ctags-for-systemverilog)
* [enable or disabling a repository using RHEL subscription Management](#enable-or-disabling-a-repository-using-rhel-subscription-management)
* [Creating a personal access token for Github](#creating-a-personal-access-token-for-github)
* [Caching your GitHub credentials in Git](#caching-your-github-credentials-in-git)
* [Manageing repositories where can i find a list of repositories](#manageing-repositories-where-can-i-find-a-list-of-repositories)
* [use centos repo for RHEL](#use-centos-repo-for-rhel)
* [linux list process by user name](#linux-list-process-by-user-name)
* [fix the pip error with Cannot fetch index base URL http://pypi.python.org/simple/ ](#fix-the-pip-error-with-cannot-fetch-index-base-url-httppypipythonorgsimple-)
* [download youtube viedo](#download-youtube-viedo)
* [ModuleNotFoundError: No module named 'apt_pkg' error](#modulenotfounderror-no-module-named-apt_pkg-error)
* [ubuntu install Nanny for parental-control](#ubuntu-install-nanny-for-parental-control)
* [fix grub rescue go with following steps](#fix-grub-rescue-go-with-following-steps)
* [install 32bits lib for ubuntu](#install-32bits-lib-for-ubuntu)

<!-- vim-markdown-toc -->


## [How do I resolve \`The following packages have unmet dependencies\`](https://stackoverflow.com/questions/26571326/how-do-i-resolve-the-following-packages-have-unmet-dependencies)  

The command to have Ubuntu fix unmet dependencies and broken packages is 

`sudo apt-get install -f` 

> -f, --fix-broken Fix; attempt to correct a system with broken dependencies in place. This option, when used with install/remove, can omit any packages to permit APT to deduce a likely solution. If packages are specified, these have to completely correct the problem. The option is sometimes necessary when running APT for the first time; APT itself does not allow broken package dependencies to exist on a system. It is possible that a system's dependency structure can be so corrupt as to require manual intervention (which usually means using dselect(1) or dpkg --remove to eliminate some of the offending packages)
    
## [How to Install Specific Version of Package using apt-get ](https://linoxide.com/linux-command/install-specific-version-package-apt-get/)  

* Check the available versions of package 
    `apt-cache madison your_package`  or 
    `apt-cache policy  your_package`
* install a specific version of package
    `apt-get install your_package=version -V`
* simulation the installation
    `apt-get install -s your_package`  You can see that it shows the process of the installation but it is a just a simulation.
* list the installed packages with the versions
    `dpkg -l | grep your_package`

## [how to check glic version on linux](http://ask.xmodulo.com/check-glibc-version-linux.html)  

* `ldd --version`
* type the glibc library (i.e., libc.so.6) from the command line
    `/lib/x86_64-linux-gnu/libc.so.6`


## [ubuntu autostart for your own script](https://www.jianshu.com/p/bdd4a914f523)  

1. open `/etc/rc.local`
    ```sh
    #!/bin/sh -e
    #
    # rc.local
    #
    # This script is executed at the end of each multiuser runlevel.
    # Make sure that the script will "exit 0" on success or any other
    # value on error.
    #
    # In order to enable or disable this script just change the execution
    # bits.
    #
    # By default this script does nothing.
    echo $LD_LIBRARY
    export PATH=/home/ubuntu/bin:$PATH
    cd /home/ubuntu/tibet
    sh OCR_Server.sh localhost 5081
    
    exec 2> /tmp/rc.local.log  # send stderr from rc.local to a log file  
    exec 1>&2                  # send stdout to the same log file  
    set -x                     # tell sh to display commands before execution
    sh test.sh 
    
    exit 0
    ```
    **Note:**
    * Must add your shell commands or scripts before 'exit 0' 
    * Must assign execute permission for your shell script as `sudo chmod +x xxx.sh`

2. add autostart script

    All autostart scripts place at `/etc/init.d/`, you can manage them by `update-rc.d`.

        cd /etc/init.d
        sudo vim local.sh
        ```sh
        #! /bin/sh
        # command content
        ssllocal -c /home/ubuntu/sxx.json
        
        exit 0
        ```
        
        sudo update-rc.d local.sh defaults 90  
        
        sudo update-rc.d -f ss_local.sh remove
        
        sudo sysv-rc-conf
        
        update-rc.d -f mysql remove
        
        sudo service --status-all

3. __Recommend to use Method 2__

4. [add autostart for aria2c](https://www.jianshu.com/p/3c1286c8a19d)


## linux generate UUID

`cat /proc/sys/kernel/random/uuid`

## change the __File Permission__ as below 

```sh
chmod   - modify file access rights
su      - temporarily become the superuser
chown   - change file ownership
chgrp   - change a file's group owner
```

## [SSH Passworldless Login Using SSH  Keygen in 5 Easy Steps](https://www.tecmint.com/ssh-passwordless-login-using-ssh-keygen-in-5-easy-steps/)

* [local] `ssh-keygen -t rsa`
* [local] `ssh name@remote_ip mkdir -p .ssh` Create .ssh Directory on remote
* [local] `cat ~/.ssh/id_rsa.pub | ssh name@remote_ip 'cat >> .ssh/authorized_keys'`  Upload Generated Public Keys to remote
* [local] `ssh name@remote_ip "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"` set .ssh Permissions on remote
* enjoy it!

## [Ubuntu User Management](https://help.ubuntu.com/lts/serverguide/user-management.html)
 
### Where is root? 
 - enable root password    -- `sudo passwd`
 - disable root password   -- `sudo passwd -l root`
 - disable root account    -- `sudo usermod --expiredate 1`

### Adding and Deleting Users
 - add a user account          -- `sudo adduser username`
 - delete a user account       -- `sudo deluser username`
 - temporarily lock accout     -- `sudo passwd -l username`
 - temporarily unlock account  -- `sudo passwd -u username`
 - add a group                 -- `sudo addgroup groupname`
 - delete a group              -- `sudo delgroup groupname`
 - add a user to a group       -- `sudo adduser username groupname`
 - add a user to a group       -- `sudo usermod -a -G groupname username`
 - del a user from a group     -- `gpasswd -d username groupname`
 - list the group              -- `/etc/group`

### Use Profile Security
 - verify the current user home directory permission : `ls -ld /home/username`, the following output shows the dir /home/username has world-readable permissions: 
  `drwxr-xr-x 2 username username 4096 2007-10-02 20:03 username`
 - remove the world readable-permission : `sudo chmod 750 /home/username`, Simply edit the file `/etc/adduser.conf` and modify the `DIR_MODE` variable to something appropriate, so that all new home diretories will receive the correct permission.
  `DIR_MODE=0750` 

### Password Policy
 - view the current status of a user account: `sudo chage -l username`
 - set password expiration: `sudo chage -E 01/31/2015 -m 5 -M 90 -I 30 -W 14 username `
     * `-E` : explicit expiration date
     * `-m` : minimum password age
     * `-M` : maximum passowrd age
     * `-I` : inactivity period after password expiration
     * `-W` : a warning time period before password expiration
 - minimum password length :  `password [success=1 default=ignore] pam_unix.so obscure sha512 minlen=8` within `/etc/pam.d/common-password`
 - SSH Access by Disabled Users 
 
Simply disabling/locking a user account will not prevent a user from logging into your server remotely if they have previously set up RSA public key authentication.
    
Remove or rename the directory `.ssh/` in the user's home folder to prevent further SSH autnetication capabilities. 
Restrict SSH access to only user accounts that should have it. eg, you may create a group called "sshlogin" and add the group name as the value associated with `AllowGroups` variable located in the file `/etc/ssh/sshd_config` 

`AllowGroups sshlogin` 

Then add your permitted SSH users to the group "sshlogin", and restart the SSH service. 
    
`sudo adduser username sshlogin`

`sudo systemctl restart sshd.service`

## ssh server in Ubuntu
    sudo apt install openssh-server 
    sudo systemctl enable ssh

## [Partitioning /home /moving](https://help.ubuntu.com/community/Partitioning/Home/Moving)

* Setup Partitions for /home
* Find the uuid of the partition
    `sudo blkid`
* Setup Fstab
*


## [Add proxy for apt](https://www.serverlab.ca/tutorials/linux/administration-linux/how-to-set-the-proxy-for-apt-for-ubuntu-18-04/) [and](https://askubuntu.com/questions/35223/syntax-for-socks-proxy-in-apt-conf/550026) 
 - socks5 proxy:  `Acquire::socks::proxy "socks5://server:port";` within `/etc/apt/apt.conf.d/12proxy`
 - http  proxy:  `Acquire::HTTP::proxy "http://server:port";` within `/etc/apt/apt.conf.d/12proxy`
 - https proxy:  `Acquire::HTTPS::proxy "http://server:port";` within `/etc/apt/apt.conf.d/12proxy`

## [List repositories on Linux](https://www.networkworld.com/article/3305810/how-to-list-repositories-on-linux.html)
`grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*`


## [sprov blog](https://blog.sprov.xyz/)

    Relative to VPS 

## [Four Spaces](https://www.4spaces.org/v2ray-nginx-tls-websocket/)

- [v2ray+tls+websocket+nginx](https://www.xpath.org/blog/001531048571577582cfa0ea2804e5f9cb224de052a4975000)
- [how to install Nginx on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-18-04)

## [Jerry Qu Blog](https://imququ.com/post/series.html)

    How to setup host

## [How to Install and Configuare VNC on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-18-04)

- remote:
    * `sudo apt update` 
    * `sudo apt install xfce4 xfce4-goodies`
    * `sudo apt install tightvncserver`
    * `vncserver` next to set password
    * `mv ~/.vnc/xstartup ~/.vnc/xstartup.bak`  backup the original `xstartup` file 
    * `vi ~/.vnc/xstartup` add below item: 

    ```bash
    #!/bin/bash
    xrdb $HOME/.Xresources
    startxfce4 &
    ```

    * `sudo chmod +x ~/.vnc/xstartup`
    * `vncserver`  start the vncserver with the latest configurate 
    * `sudo vim /etc/systemd/system/vncserver@.service` add below item to run VNC as a System Service 

    ```bash
    [Unit]
    Description=Start TightVNC server at startup
    After=syslog.target network.target
    
    [Service]
    Type=forking
    User=user_name
    Group=user_grp
    WorkingDirectory=/home/user_name
    
    PIDFile=/home/user_name/.vnc/%H:%i.pid
    ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
    ExecStart=/usr/bin/vncserver -depth 24 -geometry 1280x800 :%i
    ExecStop=/usr/bin/vncserver -kill :%i
    
    [Install]
    WantedBy=multi-user.target
    ```

    * `sudo systemctl daemon-reload` 
    * `sudo systemctl enable vncserver@1.service` 
    * `vncserver -kill :1` 
    * `sudo systemctl start vncserver@1` 
    * `sudo systemctl status vncserver@1`


- local: 
    * `sudo apt install vncviewer` 
    * `ssh -L 5901:127.0.0.1:5901 -C -N -l user_name your_server_ip` create an SSH connection on local computer that securely forwards to the `localhost` connection for VNC

## [Fix Ubuntu Chinese issue](https://blog.csdn.net/weixin_39792252/article/details/80415550) 

- `sudo apt-get install language-pack-zh-hans` 
- `sudo apt-get install fonts-droid-fallback ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming`  //install font for Chinese
- `sudo apt-get install fcitx fcitx-googlepinyin im-config`  install google-pinyin 

## [rsync](https://www.computerhope.com/unix/rsync.htm)
`rsync -az -e 'ssh -p xxx' src des`

## SVN:externals 

* [setting Up svn:externals](https://help.cloudforge.com/hc/en-us/articles/215242723-Setting-up-svn-externals)
* [How to Properly set svn:externals property In SVN command line](http://beerpla.net/2009/06/20/how-to-properly-set-svn-svnexternals-property-in-svn-command-line/)

```bash
cd path/to/workingcopy/parentofexternal/folder
svn propset svn:externals 'myDestFolderName  URL' .
svn ci
svn update
```

In order to set multiple directory/url paris in a single svn:externals property, you should put the individual dir/url pairs into a file(let's call it 'svn.externals'), like so

```vi
myDestFolderName0 URL0
myDestFolderName1 URL1
```

and then apply the property using
`svn propset svn:externals -F svn.externals .`

## MSYS2

- [pacman -Syu operation too slow](https://lb.raspberrypi.org/forums/viewtopic.php?t=24968) solutions:
    * Add a line __DisableDownloadTimeout__ to __/etc/pacman.conf__ (perhaps under "Misc options")
    * Run Pacman with the __--disable-download-timeout__ option (e.g. __pacman -Syu --disable-download-timeout__).

- USTC mirror
    * /etc/pacman.d/mirrorlist.mingw32
    Server = http://mirrors.ustc.edu.cn/msys2/mingw/i686 
    * /etc/pacman.d/mirrorlist.mingw64
    Server = http://mirrors.ustc.edu.cn/msys2/mingw/i686
    * /etc/pacman.d/mirrorlist.msys
    Server = http://mirrors.ustc.edu.cn/msys2/msys/$arch

- [Setup MSys2 + Git for Windows ](https://zhuanlan.zhihu.com/p/33751738)
    * `pacman -Sy` test the repository available
    * `https://packages.msys2.org`
    * autorebase.bat after update pacman
    * `pacman -Su` update software
    * `pacman -S git` install software git
    * `pacman -S openssh` install software openssh
    * `pacman -S mingw-w64-i686-aria2` install software aria2
    * `pacman -S libtool autoconf automake-wrapper pkg-config`
    * `pacman -S base-devel mingw-w64-i686-toolchain mingw-w64-x86_64-toolchain`

- [MSYS2 install and configuration ](https://www.cnblogs.com/fengyc/p/5156117.html)

```bash
export LANG="en_US.utf8"
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #
alias sc='source ~/.bashrc'
alias du1='du -h --max-depth=1'
alias RR='ssh -pIO username@xxx'
alias rsync="rsync -avz -e 'ssh -p 22'"
```

- [MSYS2 key is unkown](https://www.msys2.org/news/#2020-06-29-new-packages)

```
$ curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz
$ curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig

$ pacman-key --verify msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig
==> Checking msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig... (detached)
gpg: Signature made Mon Jun 29 07:36:14 2020 CEST
gpg:                using DSA key AD351C50AE085775EB59333B5F92EFC1A47D45A1
gpg: Good signature from "Alexey Pavlov (Alexpux) <alexpux@gmail.com>" [full]

# pacman -U msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz

```
If you can't even import the key and the above command fails like this:
```
error: msys: key "4A6129F4E4B84AE46ED7F635628F528CF3053E04" is unknown
:: Import PGP key 4A6129F4E4B84AE46ED7F635628F528CF3053E04? [Y/n]
[...]
error: database 'msys' is not valid (invalid or corrupted database (PGP signature))
loading packages...
error: failed to prepare transaction (invalid or corrupted database)
```
... you have to convince pacman to not care about those databases for a while, for example like this:
```
# pacman -U --config <(echo) msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz

```
If you still see signature errors, resetting your pacman key store might help:
```
# rm -r /etc/pacman.d/gnupg/
# pacman-key --init
# pacman-key --populate msys2

```

## [vim Markdown](https://github.com/plasticboy/vim-markdown)

- Vundle
    * install [Vundle](https://github.com/VundleVim/Vundle.vim)
`git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
    * Put below at the top of your `.vimrc` to use Vundle.
`source ~/.vim/bundle/Vundle.vim/test/minirc.vim`
    * launch `vim` and run `:PluginInstall` 

- vim-markdown
    * install by add below 
    ```vim 
    Plugin 'godlygeek/tabular'
    Plugin 'plasticboy/vim-markdown'
    Plugin 'mzlogin/vim-markdown-toc'
    ```
    * run inside vim `:PluginInstall`
    * Basic Usage
        - `zr` : reduces fold level throughout the buffer
        - `zR` : opens all folds
        - `zm` : increases fold level throughout the buffer
        - `zM` : folds everything all the way
        - `za` : open a fold your cursor is on
        - `zA` : open a fold your cursor is on recursively
        - `zc` : close a fold your cursor is on
        - `zC` : close a fold your cursor is on recursively
     * Toc usage
        - `GenTocGFM`       : Generate table of Contents in [GFM](https://github.github.com/gfm/) link style
        - `GenTocRedcarpet` : Generate table of Contents in [Redcarpet](https://github.com/vmg/redcarpet) link style
        - `GenTocGitLab`    : Generate table of Contents in [GitLab](https://docs.gitlab.com/ee/user/markdown.html) link style
        - `GenTocMarked`    : Generate table of contents for [iamcco/markdown-preview.vim](https://github.com/iamcco/markdown-preview.vim) which use [Marked](https://github.com/markedjs/marked) markdown parser.
        - `UpdateToc`       : update toc manually
        - `RemoveToc`       : Remove table of contents

## [markdown convert to pdf within command line](https://stackoverflow.com/questions/17630486/how-to-convert-from-a-markdown-file-to-pdf) 

* [pandoc org](https://pandoc.org/demos.html) 
* For PDF output, you’ll need `LaTeX`. We recommend installing `TeX Live` via your package manager. (On Debian/Ubuntu, `apt-get install texlive`.)
* TODO -- support Chinese

## [How to connect to Cisco AnyConnect VPN via GUI in Ubuntu 18.04](https://askubuntu.com/questions/1105683/how-to-connect-to-cisco-anyconnect-vpn-via-gui-in-ubuntu-18-04)

* `sudo apt-get install openconnect` install Cisco AnyConnect on Ubuntu
* `sudo openconnect cz.cisadd2.com` connect 
* `sudo apt install network-manager-openconnect-gnome` 

## [Connecting to Cisco VPN from Ubuntu 18.04 without a Group Password](https://askubuntu.com/questions/1033315/connecting-to-cisco-vpn-from-ubuntu-18-04-without-a-group-password) 



vpnc replaces the legacy Cisco VPN client, which used IPSec and thus required a password for a group.

__Do you need to use Cisco AnyConnect?__

If you need to use the newer Cisco Anyconnect client, you can install openconnect on Ubuntu using `sudo apt-get install network-manager-openconnect-gnome` This will add an Anyconnect compatible option to the VPN GUI under your network settings.

You can also initiate a connection by entering `sudo openconnect YOURVPN.COM` in the terminal. This will then prompt you for credentials and group settings, much like the Cisco AnyConnect client does.

If the GUI method seems confusing or isn't working at first, try the terminal method to get details about the connection you are making. I needed to restart my computer before the GUI worked. You can close the terminal connection by pressing ctrl+c in the terminal window.

After restarting, if you do not have any other credentials except a username, password, and group, you can use the GUI by:

    * Select the Cisco AnyConnect VPN Protocol
    * Enter your VPN address into the Gateway text box
    * Save the VPN Settings
    * Activate the VPN
    * Follow the prompt for your user credentials

## [linux samba](https://www.linuxidc.com/Linux/2018-11/155466.htm)

* `sudo apt-get install samba samba-common` install samba
* `sudo chmod 777 /home/linuxidc/linuxidc.com/share` create share directory
* `sudo smbpasswd -a usr_name`  create user_name and password
* `sudo vim /etc/samba/smb.conf`   configuration 

```sh
[share]
comment = share folder
browseable = yes
path = /home/linuxidc/linuxidc.com/share
create mask = 0700
directory mask = 0700
valid users = linuxidc
force user = linuxidc
force group = linuxidc
public = yes
available = yes
writable = yes
```

* `sudo systemctrl restart smbd`

## [How do I boot directly to tty1 in ubuntu?](https://askubuntu.com/questions/825094/how-do-i-boot-directly-to-tty1-in-ubuntu)

```sh
sudo systemctl enable multi-user.target --force
sudo systemctl set-default multi-user.target
startx
```

## [Make a Bash alias that takes a parameter](https://stackoverflow.com/questions/7131670/make-a-bash-alias-that-takes-a-parameter)

Bash alias does not directly accept parameters. You will have to create a function.

`alias` does not accept parameters but a function can be called just like an alias. For example:

```sh
myfunction() 
{
    #do things with parameters like $1 such as
    mv "$1" "$1.bak";
    cp "$2" "$1";
}

alias myfunction=myfunction 

or 

alias foo='__foo() { unset -f $0; echo "arg1 for foo=$1"; }; __foo()'

```

## [How to unzip a multipart (spanned) ZIP on Linux](https://unix.stackexchange.com/questions/40480/how-to-unzip-a-multipart-spanned-zip-on-linux)

`unar first_file`

1. **to create a split zip archive** you could do the following (the "-r" is the "recursive" switch to include subdirectories of the directory):
`zip -r -s 10m archive.zip directory/`

2. **To unzip the file** 

  * you first "unsplit" the ZIP file using the "-s 0" switch:
`zip -s 0 archive.zip --out unsplit.zip`
  * then you unzip the unsplit file:
`unzip unsplit.zip`

## zip the folder and deleter the original file

`zip -rmq ziped_file_name folder0 folder1 folder...`

## [NFS](https://help.ubuntu.com/lts/serverguide/network-file-system.html)

- Server: 

   1. install by  `sudo apt install nfs-kernel-server` 
   2. configuration within `/etc/exports`  

      ```
       /ubuntu  *(ro,sync,no_root_squash)
       /home    *(rw,sync,no_root_squash)
      ```

   3. start by  `sudo systemctl start nfs-kernel-server.service`


- Client

    * Linux 

        install : `sudo apt install nfs-common`
        method 1: `sudo mount example.hostname.com:/ubuntu /local/ubuntu`
        method 2: `example.hostname.com:/ubuntu /local/ubuntu nfs rsize=8192,wsize=8192,timeo=14,intr` within `/etc/fstab`

    * Windows
      __Installing the Client__ 
      1. Go to the Control Pannel -> Programs -> Programs and Features 
      2. Select: "Turn Windows features on or off" from the left hand navigation. 
      3. Scroll down to "Services for NFS" and click the "plus" on the left.
      4. Check "Client for NFS".
      5. Select "OK"
      6. Windows should install the client. Once the client package is install you will have the "mount" command available.

      __Mounting the export__
      Basic Knowledge:
      * You know and can ping the hostname of the machine with the NFS exports
      * The name of the exported filesystem (eg /export, /home/users)
      * The file systems are properly exported and accessible

          Within Command line
          `mount \\{machinename}\{filesystem} {driveletter}`

      Examples:
      ```
      mount \\filehost\home\users H:
      mount \\server1234\long\term\file S:
      mount \\nas324\exports E:
      ```

## Check Perl Library

    `perl -e 'use File::Spec;'` 
    `perl -e 'print'`
    `perl -e 'use Data::Dumper; print Dumper(\@INC);'`

## install perl lib via local::lib

```
# Install LWP and its missing dependencies to the '~/perl5' directory
perl -MCPAN -Mlocal::lib -e 'CPAN::install(LWP)'
 
# Just print out useful shell commands
$ perl -Mlocal::lib
PERL_MB_OPT='--install_base /home/username/perl5'; export PERL_MB_OPT;
PERL_MM_OPT='INSTALL_BASE=/home/username/perl5'; export PERL_MM_OPT;
PERL5LIB="/home/username/perl5/lib/perl5"; export PERL5LIB;
PATH="/home/username/perl5/bin:$PATH"; export PATH;
PERL_LOCAL_LIB_ROOT="/home/usename/perl5:$PERL_LOCAL_LIB_ROOT"; export PERL_LOCAL_LIB_ROOT;
```

## [9 simple ways to find the PID of a Program Running on Linux](http://www.2daygeek.com/check-find-parent-process-id-pid-ppid-linux/)

  - `pidof`  -- find the process ID of a running program
  - `pgrep`  -- look up or signal processes based on name and other attributes 
  - `ps`     -- report a snapshot of the current processes
  - `pstree` -- display a tree of process
  - `ss`      -- used to dump socket statistics
  - `netstat` -- displays a list of open sockets
  - `lsof`    -- list open files
  - `fuser`   -- list process IDs of all processes that have one or more open 
  - `systemctl` -- control the systemd system and service manager 

## [High Performance & Multi-threaded SCP Using RSYNC](http://ashleyangell.com/2010/09/high-performance-multi-threaded-scp-using-rsync/) 

  - `rsync -avz -e ssh remoteuser@remotehost:/remote/dir /this/dir/`
  - tar 

  ```sh
   I use ssh and tar for huge transfer (pulling):
   ssh user@remote_host tar c source | tar x
   or the other way (pushing):
   tar c source | ssh user@remote_host tar x -C /home/xxx
  ```

## [copy files and directories recursively with tar](https://www.tech-recipes.com/rx/115/copy-files-and-directories-recursively-with-tar/)  

 To copy all of the files and subdirectories in the current working directory to the diectory `/target`, use:
 `tar cf - * | ( cd /target; tar xfp -)` 

The first part of the command before the pipe instruct tar to create an archive of everything in the current directory and write it to standard output (the – in place of a filename frequently indicates stdout). The commands within parentheses cause the shell to change directory to the target directory and untar data from standard input. Since the cd and tar commands are contained within parentheses, their actions are performed together.

The -p option in the tar extraction command directs tar to preserve permission and ownership information, if possible given the user executing the command. If you are running the command as superuser, this option is turned on by default and can be omitted.


## [DataRecovery](https://help.ubuntu.com/community/DataRecovery) 

Deleted or lost files can sometimes be recovered from failed or formatted drives and partitions, CD-ROMs and memory cards using the free/libre software available in the Ubuntu repositories. The data is recoverable because the information is not immediately removed from the disk. Follow these steps to recover lost data.

* Lost Partition 
    - GNU Parted
    - testdisk
    - Gpart
* Imaging a damaged device, filesystem or drive 
    - software choices
    - Ran out of space while imaging the drive 
* Extract filesystem from recovered image  
    - mounting partitions on the image
* Extract individual files from recovered image 
    - Foremost
    - Scalpel
    - Magic Rescue
    - Photorec
    -recoverjpeg
* Ntfsprogs 
* Sleuth Kit and Autopsy 
* Cleaning up
* Prevention 


## check the Linux OS
* method 1 
```
      ## if system is Redhat
    OS=`cat /etc/redhat-release | awk {'print $1}'`
    if [ "$OS" != "CentOS" ] ; then
    
        echo "System runs on Redhat Linux.";
    
        do 
        xxxx
        done
    
        exit;
    fi

```
* method 2 
```
        cat /proc/version

        and Grep for words "Red" and "CentOS" you can event get the version from the same.
```
* method 3 

`cat /etc/os-release  | grep VERSION_ID | sed -n 's/.*"\(.*\)"/\1/p'`

* method 4 

`cat /etc/issue`


## [How to find what other machines are connected to the local network](https://unix.stackexchange.com/questions/8118/how-to-find-what-other-machines-are-connected-to-the-local-network)

* `arp` 
* `ip neigh` 
* install `nmap` and run `nmap -sP 192.168.1.*`

## [how can you find and replace text in a file using the Windows command_line env](https://stackoverflow.com/questions/60034/how-can-you-find-and-replace-text-in-a-file-using-the-windows-command-line-envir)

 
1. `powershell -Command "(gc myFile.txt) -replace 'foo', 'bar' | Out-File -encoding ASCII myFile.txt"`

  *  powershell starts up powershell.exe, which is included in Windows 7
  *  -Command "... " is a command line arg for powershell.exe containing the command to run
  *  (gc myFile.txt) reads the content of myFile.txt (gc is short for the Get-Content command)
  *  -replace 'foo', 'bar' simply runs the replace command to replace foo with bar
  *  | Out-File myFile.txt pipes the output to the file myFile.txt
  *  -encoding ASCII prevents transcribing the output file to unicode, as the comments point out


2.  `type test.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"foo\", \"bar\" }" > outputFile.txt`

## [Command Line Reference](https://ss64.com)

## [How to install RPM file on Linux](https://phoenixnap.com/kb/how-to-install-rpm-file-centos-linux)

* `sudo rpm -i xxx.rpm` 
* `sudo yum localinstall xxx.rpm`
* `sudo rpm -e xxx.rpm`   remove RPM package
* `sudo rpm -qpR xxx.rpm` check dependencies
* `sudo yumdownloader packagname` download RPM package

## [RPM Package](https://centos.pkgs.org/7/centos-x86_64/boost-devel-1.53.0-27.el7.x86_64.rpm.html)

## [How to download a RPM Package with all dependencies in CentOS](https://www.ostechnix.com/download-rpm-package-dependencies-centos/)

https://www.thegeekdiary.com/downloading-rpm-packages-with-dependencies-yumdownloader-vs-yum-downloadonly-vs-repoquery/

## [Need to set up yum repository for locally-mounted DVD on RHEL](https://access.redhat.com/solutions/1355683)

## [How to setup local yum reposity on CentOS 7](https://phoenixnap.com/kb/create-local-yum-repository-centos)

## [How to setup yum reposity using locally mounted DVD](https://www.thegeekdiary.com/centos-rhel-7-how-to-setup-yum-repository-using-locally-mounted-dvd/)

## [Create ISO from DVD](https://help.ubuntu.com/community/CreateIsoFromCDorDVD)

`dd if=/dev/cdrom of=file.iso` (assuming /dev/cdrom is where the CD is mounted, and file.iso is the name you want ti give the ISO, in the current directory)

## [Disabling the subscription mamager repository RHEL](https://access.redhat.com/documentation/en-us/red_hat_subscription_management/1/html/rhsm/yum-disable)

`subscription-manager config --rhsm.manage_repos=0`

## [ctags for systemverilog](https://verificationacademy.com/forums/systemverilog/ctags-systemverilog)

```
--exclude=.SOS
--exclude=.git
--exclude=nobackup
--exclude=nobkp

--langdef=systemverilog
--langmap=systemverilog:.v.vg.sv.svh.tv.vinc

--regex-systemverilog=/^\s*(\b(static|local|virtual|protected)\b)*\s*\bclass\b\s*(\b\w+\b)/\3/c,class/
--regex-systemverilog=/^\s*(\b(static|local|virtual|protected)\b)*\s*\btask\b\s*(\b(static|automatic)\b)?\s*(\w+::)?\s*(\b\w+\b)/\6/t,task/
--regex-systemverilog=/^\s*(\b(static|local|virtual|protected)\b)*\s*\bfunction\b\s*(\b(\w+)\b)?\s*(\w+::)?\s*(\b\w+\b)/\6/f,function/

--regex-systemverilog=/^\s*\bmodule\b\s*(\b\w+\b)/\1/m,module/
--regex-systemverilog=/^\s*\bprogram\b\s*(\b\w+\b)/\1/p,program/
--regex-systemverilog=/^\s*\binterface\b\s*(\b\w+\b)/\1/i,interface/
--regex-systemverilog=/^\s*\btypedef\b\s+.*\s+(\b\w+\b)\s*;/\1/e,typedef/
--regex-systemverilog=/^\s*`define\b\s*(\w+)/`\1/d,define/
--regex-systemverilog=/}\s*(\b\w+\b)\s*;/\1/e,typedef/

--regex-systemverilog=/^\s*(\b(static|local|private|rand)\b)*\s*(\b(shortint|int|longint)\b)\s*(\bunsigned\b)?(\s*\[.+\])*\s*(\b\w+\b)/\7/v,variable/
--regex-systemverilog=/^\s*(\b(static|local|private|rand)\b)*\s*(\b(byte|bit|logic|reg|integer|time)\b)(\s*\[.+\])*\s*(\b\w+\b)/\6/v,variable/
--regex-systemverilog=/^\s*(\b(static|local|private)\b)*\s*(\b(real|shortreal|chandle|string|event)\b)(\s*\[.+\])*\s*(\b\w+\b)/\6/v,variable/
--regex-systemverilog=/(\b(input|output|inout)\b)?\s*(\[.+\])*\s*(\b(wire|reg|logic)\b)\s*(\[.+\])*\s*(#(\(.+\)|\S+)\))?\s*(\b\w+\b)/\9/v,variable/
--regex-systemverilog=/(\b(parameter|localparam)\b).+(\b\w+\b)\s*=/\3/a,parameter/

--systemverilog-kinds=+ctfmpied

--languages=systemverilog,C,C++,HTML,Lisp,Make,Matlab,Perl,Python,Sh,Tex
```

## [enable or disabling a repository using RHEL subscription Management](https://access.redhat.com/solutions/265523)

## [Creating a personal access token for Github](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token)

## [Caching your GitHub credentials in Git](https://docs.github.com/en/free-pro-team@latest/github/using-git/caching-your-github-credentials-in-git)

1. In Terminal, enter the following:
```
git config --global credential.helper cache
# Set git to use the credential memory cache
```
2. To change the default password cache timeout, enter the following :
```
git config --global credential.helper 'cache --timeout=3600'
# set the cache to timeout after 1 hour
```

## [Manageing repositories where can i find a list of repositories](https://access.redhat.com/discussions/750393)

## [use centos repo for RHEL](https://unix.stackexchange.com/questions/433046/how-do-i-enable-centos-repositories-on-rhel-red-hat)

create a new repository centos.repo in `/etc/yum.repos.d/` with the content:

```
[centos]
name=CentOS-7
baseurl=http://ftp.heanet.ie/pub/centos/7/os/x86_64/
enabled=1
gpgcheck=1
gpgkey=http://ftp.heanet.ie/pub/centos/7/os/x86_64/RPM-GPG-KEY-CentOS-7
```

then run 
`yum repolist`

check if you can install any package like
`yum install nmap -y`

----------------------

You can use repo-file from CentOS, but need to prepare it:

    Replace $releasever inside this file with the appropriate release number (e.g. 7 for RHEL-7):

    `sed -i 's/$releasever/7/g' /etc/yum.repos.d/CentOS-Base.repo`

    Download key:

    `curl http://mirror.centos.org/centos/7/os/x86_64/RPM-GPG-KEY-CentOS-7 >/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7`

    or change inside repo-file gpgkey's:

    `gpgkey=http://mirror.centos.org/centos/7/os/x86_64/RPM-GPG-KEY-CentOS-7`

-----------------------

[Top 5 Yum Repository](https://tecadmin.net/top-5-yum-repositories-for-centos-rhel-systems/)

## [linux list process by user name](https://www.cyberciti.biz/faq/linux-list-processes-by-user-names-euid-and-ruid/)

1. `top -u {userName}`
2. `pgrep -u {userName} {processName}`
3. `ps -u {userName}`
4. `ps -elF`
5. `pstree -aph`

## [fix the pip error with Cannot fetch index base URL http://pypi.python.org/simple/ ](https://www.cnblogs.com/jonnyan/p/9181031.html)

  caused by blocked by CDN like github. You can fix it by adding mirror as below:

    `pip --trusted-host pypi.mirrors.ustc.edu.cn install paramiko -i http://pypi.mirrors.ustc.edu.cn/simple`

    mirrors at GFW:
    1. http://pypi.douban.com
    2. http://pypi.hustunique.com
    3. http://pypi.sdutlinux.org
    4. http://pypi.mirrors.ustc.edu.cn
  
   You can also add configuration file as below(Linux: ~/.pip/pip.conf, windows: %HOMEPATH%\pip\pip.ini)
   ```sh
   [global]
   index-url = http://pypi.mirrors.ustc.edu.cn/simple
   ```
## download youtube viedo

1. [youtube-dl](https://github.com/ytdl-org/youtube-dl)  
`youtube-dl --proxy socks5://127.0.0.1:1080/    URL`

2. [annie](https://github.com/iawia002/annie)  
`HTTP_PROXY="socks5://127.0.0.1:1080/" annie -i URL`

## [ModuleNotFoundError: No module named 'apt_pkg' error](https://askubuntu.com/questions/1069087/modulenotfounderror-no-module-named-apt-pkg-error)


    I run below command on ubuntu 16.4 :
    
    `sudo add-apt-repository ppa:noobslab/apps`

solution:  
` /usr/lib/python3/dist-packages# sudo cp apt_pkg.cpython-35m-x86_64-linux-gnu.so apt_pkg.so`

## [ubuntu install Nanny for parental-control](https://sites.google.com/site/installationubuntu/security/parental-control-for-internet)

1. `sudo add-apt_pkg ppa:nanny`
2. `sudo apt-get update && sudo apt-get install nanny`

## [fix grub rescue go with following steps](https://askubuntu.com/questions/192621/grub-rescue-prompt-repair-grub)


1. First thing is we have to start our OS only then after we can fix grub
```
    #to start OS
    error: unknow filesystem
    Entering rescue mode...
    grub rescue>
```
when you can see such an error first we have to check for filesystem is ext2
```
    grub rescue: ls  # show as below
    (hd0) (hd0,msdos6) (hd0,msdos7)
```
this are our drives now we have to check which one is ext2
```
    grub rescue> ls (hd0,msdos6)
    error: disk 'hd,msdos6' not found
```
go for another drives until you get "Filesystem is ext2"
```
    grub rescue> ls (hd0,msdos7)
    (hd0,msdos7): Filesystem is ext2
```
now set the path 
```
    grub rescue> set boot=(hd0,msdos7)
    grub rescue> set prefix=(hd0,msdos7)/boot/grub
    grub rescue> insmod normal
    grub rescue> normal
```
2. Now just fix grub by following command on any ubuntu 
```
    sudo grub-install /dev/sda
```

## install 32bits lib for ubuntu


fix below issue
` /usr/local/openjdk-8/jre/lib/amd64/libawt_xawt.so: libXrender.so.1: `

```
    dpkg --add-architecture i386
    apt-get update
    sudo apt-get install build-essential
    apt -y install libxext6
    apt-get -y install libbz2-1.0:i386 libxrender1:i386 libxtst6:i386 libxi6:i386
    apt-get -y install libxrender1 libxtst6 libxi6
    apt install default-jre default-jdk lsb dos2unix
    apt install libxft2 libxft2:i386


```



<!-- vim-markdown-toc GFM -->

<!-- vim-markdown-toc -->
