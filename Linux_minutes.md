# Minutes about Linux Envariable

Table of Contents
=================

<!-- vim-markdown-toc GitLab -->

* [server.sh](#serversh)
* [cfg windows env ](#cfg-windows-env-)
* [python for vscode](#python-for-vscode)
* [offline download the package from PPA](#offline-download-the-package-from-ppa)
* [Pulseview](#pulseview)
* [clean ubuntu disk](#clean-ubuntu-disk)
* [修改当前目录及其子目录中的所有 700 权限文件夹](#修改当前目录及其子目录中的所有-700-权限文件夹)
* [系统级路径设置（需要管理员权限）](#系统级路径设置需要管理员权限)
* [　Samba Tips](#samba-tips)
    * [1. **确保已安装 Samba**](#1-确保已安装-samba)
    * [2. **创建系统用户（可选）**](#2-创建系统用户可选)
    * [3. **添加 Samba 账户并设置密码**](#3-添加-samba-账户并设置密码)
    * [4. **验证 Samba 账户**](#4-验证-samba-账户)
    * [5. **配置 Samba 共享目录（可选）**](#5-配置-samba-共享目录可选)
    * [6. **管理 Samba 账户的其他命令**](#6-管理-samba-账户的其他命令)
    * [7. **常见问题与注意事项**](#7-常见问题与注意事项)
    * [总结](#总结)
* [lsf](#lsf)
* [ubuntu sync time to ntp to solve clock skew issue](#ubuntu-sync-time-to-ntp-to-solve-clock-skew-issue)
* [Excel with Regex (VBA)](#excel-with-regex-vba)
* [print all windows enviroment variables](#print-all-windows-enviroment-variables)
* [JLink Script](#jlink-script)
* [How to format a USB flash drive](#how-to-format-a-usb-flash-drive)
* [Typora and Diagram](#typora-and-diagram)
* [vim substitute](#vim-substitute)
* [How do I resolve The following packages have unmet dependencies](#how-do-i-resolve-the-following-packages-have-unmet-dependencies)
* [How to Install Specific Version of Package using apt-get ](#how-to-install-specific-version-of-package-using-apt-get-)
* [how to check glic version on linux](#how-to-check-glic-version-on-linux)
* [ubuntu autostart for your own script](#ubuntu-autostart-for-your-own-script)
* [linux generate UUID](#linux-generate-uuid)
* [change the __File Permission__ as below](#change-the-__file-permission__-as-below)
* [SSH Passworldless Login Using SSH  Keygen in 5 Easy Steps](#ssh-passworldless-login-using-ssh-keygen-in-5-easy-steps)
* [Ubuntu User Management](#ubuntu-user-management)
    * [Where is root?](#where-is-root)
    * [Adding and Deleting Users](#adding-and-deleting-users)
    * [Use Profile Security](#use-profile-security)
    * [Password Policy](#password-policy)
* [ssh server in Ubuntu](#ssh-server-in-ubuntu)
* [how to disconnect and connect the wired connection from the command line](#how-to-disconnect-and-connect-the-wired-connection-from-the-command-line)
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
* [High Performance & Multi-threaded SCP Using RSYNC](#high-performance-multi-threaded-scp-using-rsync)
* [copy files and directories recursively with tar](#copy-files-and-directories-recursively-with-tar)
* [DataRecovery](#datarecovery)
* [check the Linux OS](#check-the-linux-os)
* [How to find what other machines are connected to the local network](#how-to-find-what-other-machines-are-connected-to-the-local-network)
* [How to find what other machines are connected to the local network](#how-to-find-what-other-machines-are-connected-to-the-local-network-1)
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
* [Create a Github repository](#create-a-github-repository)
    * [create a new repository on the command line](#create-a-new-repository-on-the-command-line)
    * [push an existing repository from the command line](#push-an-existing-repository-from-the-command-line)
    * [push by PAT](#push-by-pat)
* [Clone A Private Repository Github](#clone-a-private-repository-github)
* [Github Connect with SSH](#github-connect-with-ssh)
* [Manage remote repositories](#manage-remote-repositories)
    * [switching remote URLs from HTTPS to SSH](#switching-remote-urls-from-https-to-ssh)
* [Manageing repositories where can i find a list of repositories](#manageing-repositories-where-can-i-find-a-list-of-repositories)
* [use centos repo for RHEL](#use-centos-repo-for-rhel)
* [linux list process by user name](#linux-list-process-by-user-name)
* [fix the pip error with Cannot fetch index base URL http://pypi.python.org/simple/ ](#fix-the-pip-error-with-cannot-fetch-index-base-url-httppypipythonorgsimple-)
* [download youtube viedo](#download-youtube-viedo)
* [ModuleNotFoundError: No module named 'apt_pkg' error](#modulenotfounderror-no-module-named-apt_pkg-error)
* [ubuntu install Nanny for parental-control](#ubuntu-install-nanny-for-parental-control)
* [fix grub rescue go with following steps](#fix-grub-rescue-go-with-following-steps)
* [install 32bits lib for ubuntu](#install-32bits-lib-for-ubuntu)
* [learn X in Y mininuts](#learn-x-in-y-mininuts)
* [Docker for Unbuntu](#docker-for-unbuntu)
    * [uninstall](#uninstall)
    * [install](#install)
    * [Manage Docker as a non-root user](#manage-docker-as-a-non-root-user)
    * [Usage](#usage)
    * [docker with the same UID/GID](#docker-with-the-same-uidgid)
    * [docker with vnc](#docker-with-vnc)
    * [How to move docker data directory to another location on Ubuntu](#how-to-move-docker-data-directory-to-another-location-on-ubuntu)
* [crontab](#crontab)
* [Docker Create for VNC](#docker-create-for-vnc)
    * [Dockerfile](#dockerfile)
    * [create `start-vnc.sh`](#create-start-vncsh)
* [pip source from aliyun](#pip-source-from-aliyun)

<!-- vim-markdown-toc -->

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
* [NFS](#nfs)
* [Check Perl Library](#check-perl-library)
* [install perl lib via local::lib](#install-perl-lib-via-locallib)
* [9 simple ways to find the PID of a Program Running on Linux](#9-simple-ways-to-find-the-pid-of-a-program-running-on-linux)
* [High Performance & Multi-threaded SCP Using RSYNC](#high-performance--multi-threaded-scp-using-rsync)
* [copy files and directories recursively with tar](#copy-files-and-directories-recursively-with-tar)
* [DataRecovery](#datarecovery)
* [check the Linux OS](#check-the-linux-os)
* [linux list process by user name](#linux-list-process-by-user-name)
* [fix the pip error with Cannot fetch index base URL http://pypi.python.org/simple/ ](#fix-the-pip-error-with-cannot-fetch-index-base-url-httppypipythonorgsimple-)

<!-- vim-markdown-toc -->

## server.sh

```
#!/usr/bin/env sh
#
# Copyright (c) Microsoft Corporation. All rights reserved.
#

case "$1" in
	--inspect*) INSPECT="$1"; shift;;
esac

ROOT="$(dirname "$0")"

"$ROOT/node" ${INSPECT:-} "$ROOT/out/server-main.js" --compatibility=1.63 --accept-server-license-terms "$@"
```

## [cfg windows env ](https://sysin.org/blog/windows-env/)

## [python for vscode](https://code.visualstudio.com/docs/python/environments)  
 * activate venv
```ps
Set-ExecutionPolicy Unrestricted -Scope Process
 & d:/python/tk/.venv/Scripts/Activate.ps1
```

## offline download the package from PPA

1. found your os `cat /etc/os-release`
2. If you want to get a specific .deb file for a package from a PPA, you can download it directly from the PPA's page on Launchpad. 

    * Find the PPA on Launchpad: Use the PPA's identifier to navigate to its Launchpad page. For instance, the KiCad 8.0 releases PPA is at https://launchpad.net/~kicad/+archive/ubuntu/kicad-8.0-releases.
    * View Package Details: On the PPA's page, click on "View package details".
    * Select your Ubuntu Version: You'll see a list of packages available for different Ubuntu releases. Choose the one that matches your system.
    * Download the .deb: Find the package you want (e.g., kicad) and click the link to download the .deb file for your architecture (e.g., _amd64.deb). 
3. copy the \*.deb to `/var/cache/apt/archives`

## Pulseview

sudo apt-get install libboost-all-dev  libqt5svg5-dev qttools5-dev qtbase5-dev qtchooser qt5-qmake libgtkmm-3.0-dev  autoconf-archive libsigrok-dev libglibmm-2.4-dev  qt5-qmake libsigrokcxx-dev libsigrok-dev

##  clean ubuntu disk 

1. [clean journal](.misc/lear_systemd_journal_logs.md)

2. clean apt 

   ```
   sudo apt-get autoremove && sudo apt-get autoclean
   ```

   
##  修改当前目录及其子目录中的所有 700 权限文件夹

```bash
find . -type d -perm 700 -exec chmod 755 {} \;
```

这将把当前目录及其所有子目录中权限为 700 的文件夹改为 755（所有者有全部权限，其他用户有读和执行权限）。



## 系统级路径设置（需要管理员权限）

如果您想让路径对所有用户可用，可以修改系统级配置文件：

1. 创建或编辑 `/etc/profile.d/custom_paths.sh`：

   ```bash
   sudo nano /etc/profile.d/custom_paths.sh
   ```

2. 添加路径设置：


   ```bash
   # 系统级自定义路径
   export PATH="$PATH:/usr/local/custom/bin"
   ```

3. 使脚本可执行：


   ```bash
   sudo chmod +x /etc/profile.d/custom_paths.sh
   ```

4. 重新登录或启动新终端会话使更改生效


## 　Samba Tips

### 1. **确保已安装 Samba**

在添加 Samba 账户之前，请确保系统已安装 Samba 服务。如果尚未安装，可以使用以下命令安装：

```bash
sudo apt update
sudo apt install samba
```

安装完成后，您可以检查 Samba 版本以确认安装成功：`samba -V`。

------

###  2. **创建系统用户（可选）**

Samba 账户必须基于一个现有的系统用户。如果还没有合适的系统用户，请先创建：

```bash
sudo useradd -m -s /bin/bash username  # 创建用户并生成家目录
sudo passwd username      # 为该用户设置系统登录密码
```

其中 `username` 是您想要创建的用户名。



### 3. **添加 Samba 账户并设置密码**

使用 `smbpasswd` 命令为系统用户添加 Samba 账户并设置密码（此密码用于访问 Samba 共享）：

```bash
sudo smbpasswd -a username
```

系统会提示您输入并确认 Samba 密码。此密码可以与系统登录密码不同。

------

### 4. **验证 Samba 账户**

添加完成后，您可以使用 `pdbedit` 命令列出所有已配置的 Samba 账户以进行验证：

```bash
sudo pdbedit -L -v
```

此命令会显示所有 Samba 用户的列表。



### 5. **配置 Samba 共享目录（可选）**

您可能需要编辑 Samba 配置文件 `/etc/samba/smb.conf` 来设置共享目录。例如，添加以下内容

```ini
[share]
   comment = Shared Folder
   path = /home/username/share
   valid users = username
   read only = no
   browsable = yes
```

之后重启 Samba 服务使配置生效：

```bash
sudo service smbd restart
# 或
sudo systemctl restart smbd
```

请确保共享目录的权限设置正确（例如使用 `chmod` 和 `chown`）。

------

### 6. **管理 Samba 账户的其他命令**

- **禁用 Samba 账户**：

  ```bash
  sudo smbpasswd -d username
  ```

- **启用 Samba 账户**：

  ```bash
  sudo smbpasswd -e username
  ```

- **删除 Samba 账户**：

  ```bash
  sudo smbpasswd -x username
  ```

  注意：这不会删除系统用户。

------

### 7. **常见问题与注意事项**

- **用户必须存在**：`smbpasswd -a` 添加的用户必须是已有的系统用户，否则会报错 `Failed to find entry for user`7。

- **密码同步**：Samba 账户密码与系统用户密码是独立的。更改系统密码不会影响 Samba 密码，反之亦然。

- **安全性**：建议使用强密码，并定期更新。在配置文件 `smb.conf` 中，设置 `security = user` 以启用用户级安全认证15。

- **防火墙**：如果启用了防火墙（如 `ufw`），确保允许 Samba 流量：

  ```bash
  sudo ufw allow samba
  ```

------

### 总结

添加 Samba 账户的关键步骤是：

1. 确保有系统用户。
2. 使用 `sudo smbpasswd -a username` 添加 Samba 密码。
3. 如需共享目录，则配置 `/etc/samba/smb.conf` 并重启服务。

完成这些步骤后，用户就应该能够使用其 Samba 凭证访问共享资源了。如果在 Windows 访问时遇到问题，可以检查网络连接、防火墙设置以及 Samba 配置中的工作组名称（通常应与 Windows 工作组一致，如 `WORKGROUP`）。


## lsf

* [IBM Platform LSF Documentation](https://www.bsc.es/support/LSF/9.1.2/)
* [bhist](https://www.ibm.com/docs/en/spectrum-lsf/10.1.0?topic=reference-bhist#bhist_ref3495__timeformat273684)
* [Get CWD of bjobs in LSF environment](https://stackoverflow.com/questions/30816868/get-cwd-of-bjobs-in-lsf-environment)

 ```
$ bjobs -o 'jobid exec_cwd' 5950
JOBID EXEC_CWD
5950  /home/squirrel/cwd
 ```

 The `-UF` option to bjobs will display the same output at the `-l` option, but in an "unformatted" way. This will basically take all of those job events that are currently split into many lines and display each one on a single line for easier parsing.
 * [Finding historical job information of old completed jobs](https://www.ibm.com/support/pages/finding-historical-job-information-old-completed-jobs)

## ubuntu sync time to ntp to solve clock skew issue

`ntpdate cn.pool.ntp.org`

## Excel with Regex (VBA)

* [stackoverflow](https://stackoverflow.com/questions/22542834/how-to-use-regular-expressions-regex-in-microsoft-excel-both-in-cell-and-loops)
* [software-solution](https://software-solutions-online.com/vba-regex-guide/)

## print all windows enviroment variables

`PS C:\> dir env: >env.txt`

## JLink Script
* basic usage: `JLink.exe -JLinkScriptFile MyFile.JLinkScript`
* [Basic of Jlink script and used for IAR](https://www.cnblogs.com/henjay724/p/14008691.html)
* [J-Link_script_files from SEGGER](https://wiki.segger.com/J-Link_script_files#Global_DLL_variables)
* [Jlink for Raspberry](https://mlog.club/article/3483195)  
`Command line: -if jtag -device Cortex-A53 -endian little -speed auto -port 2331 -swoport 2332 -telnetport 2333 -vd -ir -localhostonly 1 -singlerun -strict -timeout 0 -nogui -jlinkscriptfile /home/piotr/rpi.JLinkScript`


## [How to format a USB flash drive](https://askubuntu.com/questions/22381/how-to-format-a-usb-flash-drive)


   * To show the USB drive among all storage partitions and volumes on your computer use:       

    `lsblk` or `df` or `fdisk -l`    
   * Suppose it may be `/dev/sdy1`. Unmount it with:       

    `sudo umount /dev/sdy1`    
   * To format drive with the FAT32 file system format:  

    `mkdosfs -F 32 -I /dev/sdxx` or 
    `sudo mkfs.vfat -F 32 /dev/sdy1`  
   * To set a file system label for your pen drive in the process:  

    `sudo mkfs.vfat -F 32 -n 'name_for_your_pendrive' /dev/sdy1`  
    You must include the `-F 32` part to specify the FAT size, it is not 32 by default in ubuntu 19.10. For more info see man mkfs.fat.  
   * Eject the device:  

    `sudo eject /dev/sdb`  


## Typora and Diagram

* [Typora](https://typora.io/)
* [Typora Beta](https://github.com/HowardWhile/typora-beta)
* [Diagram by mermaid](https://mermaid-js.github.io/mermaid/#/README)

## [vim substitute](http://vimregex.com/#substitute)


## [How do I resolve The following packages have unmet dependencies](https://stackoverflow.com/questions/26571326/how-do-i-resolve-the-following-packages-have-unmet-dependencies)  

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

## [how to disconnect and connect the wired connection from the command line](https://askubuntu.com/questions/1218779/how-to-disconnect-and-connect-the-wired-connection-from-the-command-line)

Get `ifname` as below

    ifname=$(nmcli dev status | grep ethernet | sed 's/ .*//g')

You can try using `nmcli` to disconnect and re-connect a particular network `deivce` ex.

     nmcli dev disconnect enp0s25 && nmcli dev connect enp0s25

where the wired `ifname` `enp0s25` may be obtained if you don't already know it using `nmcli dev status`

    $ nmcli dev status
    DEVICE  TYPE    STATE           CONNECTION
    enp0s25 ethernet unavailable    --
    lo      loopback unmanaged      --


## [Partitioning /home /moving](https://help.ubuntu.com/community/Partitioning/Home/Moving)

   [local URL](./misc/ubuntu_partition_home.md)

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
    `pandoc -s -r html xxx -o xx.md`
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
* `pdbedit -L -v`   list all samba user
* `sudo service smbd restart`  restart samba service
* `sudo ufw allow samba`  Update the firewall rules to allow Samba traffic

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

## Create a Github repository

### create a new repository on the command line               

```shell
echo "# Docs" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/xxx/xxx.git
git push -u origin main
```

### push an existing repository from the command line                  

```shell
git remote add origin https://github.com/xxx/xxx.git
git branch -M main
git push -u origin main
```

### push by PAT

1. update URL
```shell
git remote set-url origin https://[token]@github.com/user_name/[repo].git /dev/null 2>&1
```
2. command with token
```shell
git push https://[token]@github.com/user_name/[repo].git
```
3. command with username
```shell
git push 
Username: your_token
Password:
```



## [Clone A Private Repository Github](https://stackoverflow.com/questions/2505096/clone-a-private-repository-github)

`git clone git@github.com:username/xxx.git`



## [Github Connect with SSH](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/checking-for-existing-ssh-keys)

1. check for existing SSH key

   * Enter `ls -al ~/.ssh` to see if existing SSH keys are present:

   * Check the directory listing to see if you already have a public SSH  key. By default, the filenames of the public keys are one of the  following:
     * *id_rsa.pub*
     * *id_ecdsa.pub*
     * *id_ed25519.pub*

2. generate new SSH key

   * generate ed25529  key

     ```shell
     ssh-keygen -t ed25519 -C "your_email@example.com"
     ```

   * generate  legacy rsa key

     ```shell
     $ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
     ```

3. Add a new SSH key

   * copy your public key to the clipboard

   * In the upper-right corner of any page, click your profile photo, then click **Settings**.

     ![Settings icon in the user bar](Linux_minutes.assets/userbar-account-settings.png)

   * In the user settings sidebar, click **SSH and GPG keys**.

     ![Authentication keys](Linux_minutes.assets/settings-sidebar-ssh-keys.png)

   * Click **New SSH key** or **Add SSH key**.

     ![SSH Key button](Linux_minutes.assets/ssh-add-ssh-key.png)

   * In the "Title" field, add a descriptive label for the new key. For  example, if you're using a personal Mac, you might call this key  "Personal MacBook Air".

   * Paste your key into the "Key" field.

     ![The key field](Linux_minutes.assets/ssh-key-paste.png)

4. Test your SSH connection

   ```shell
   ssh -T git@github.com
   ```

5. SSH key passphrases

   ```shell
   ssh-keygen -p -f ~/.ssh/id_ed25519
   > Enter old passphrase: [Type old passphrase]
   > Key has comment 'your_email@example.com'
   > Enter new passphrase (empty for no passphrase): [Type new passphrase]
   > Enter same passphrase again: [Repeat the new passphrase]
   > Your identification has been saved with the new passphrase.
   ```

## [Manage remote repositories](https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories#switching-remote-urls-from-https-to-ssh)

### switching remote URLs from HTTPS to SSH

1. list your existing remotes in order to get the name of the remote you want to change

   ```shell
   $ git remote -v
   > origin  https://github.com/USERNAME/REPOSITORY.git (fetch)
   > origin  https://github.com/USERNAME/REPOSITORY.git (push)
   ```

2. change your remote's URL from HTTPS to SSH

   ```shell
   $ git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
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

  list all available format, default is best

  `youtube-dl --proxy socks5://127.0.0.1:1080/  -F  URL`

  select special format

  `youtube-dl --proxy socks5://127.0.0.1:1080/  -f xx  URL`

2. Get youtube-dl

  ```
  sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
  sudo chmod a+rx /usr/local/bin/youtube-dl
  ```

3. [annie](https://github.com/iawia002/annie)  
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

## [learn X in Y mininuts](https://learnxinyminutes.com/)

## [Docker for Unbuntu](https://docs.docker.com/engine/install/ubuntu/)

### uninstall

1. Uninstall the Docker Engine, CLI, and Containerd packages:

    `sudo apt-get purge docker-ce docker-ce-cli containerd.io`

2. mages, containers, volumes, or customized configuration files on your host are not automatically removed. To delete all images, containers, and volumes:

```
     sudo rm -rf /var/lib/docker
     sudo rm -rf /var/lib/containerd
```

You must delete any edited configuration files manually.

### install

1. Update the `apt` package index and install packages to allow `apt` to use a repository over HTTPS:

```
    sudo apt-get update

    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
```

2. Add Docker’s official GPG key:

```
     curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

3. Use the following command to set up the stable repository. To add the nightly or test repository, add the word nightly or test (or both) after the word stable in the commands below. Learn about nightly and test channels.

```
    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

4. install Docker Engine

```
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
```

### Manage Docker as a non-root user

1. Create the `docker` group.

    `sudo groupadd docker`

2. Add your user to the docker group.

    `sudo usermod -aG docker $USER`

3. Log out and log back in so that your group membership is re-evaluated.

    `newgrp docker` 

4. Verify that you can run docker commands without `sudo`.

    `docker run hello-world`

### Usage

1. search 

    `docker search ubuntu`

2. pull

    `docker pull ubuntu `

3. remove

    `docker image rm "image_name"`

4. create container

```
    docker run [option] image_name [cmd forward to container]

    docker create -v map_to_dir:path_within_image -it --name xx image_name
    docker run -itd --name=xxx image_name /bin/bash
```

5. use a container

    `docker exec -it -w directory_after_enter_container container_name /bin/bash`

6. list container

    `docker ps -a`

7. start, stop or kill a container

```
    docker container start xxx
    docker container stop xxx
    docker container kill xxx
```

8. remove a container

    `docker container rm xxx`

9. save container as image

    `docker commit container_name image_name`

10. image save and distributor

```
    docker save -o file_name image_name
    docker load -i file_name
```


11. [Share folder between host and container](https://forums.docker.com/t/share-folder-between-host-and-container/97370)


>> Docker has the ability to keep data on the host even during restarts and upgrades. This is called bind mounts. You can read about it here: https://docs.docker.com/storage/bind-mounts/. Using the example in the documentation you could use the following command to bind the app directory to a subdirectory target in current local directory where you run this command. Any data in the subdirectory gets automatically added to the container at startup and any changes in the running container gets added to your directory. I believe this is what you are looking for.
>> Ex:
>> 
```
docker run -d \
  -it \
  --name devtest \
  -v "$(pwd)"/target:/app \
  nginx:latest

```

12. [Downloading Docker Images from Docker Hub without using Docker](https://devops.stackexchange.com/questions/2731/downloading-docker-images-from-docker-hub-without-using-docker)

It turned out that the [Moby Project](https://mobyproject.org/) has a shell script on the [Moby Github](https://github.com/moby/moby/) which can download images from Docker Hub in a format that can be imported into Docker:

    [download-frozen-image-v2.sh](https://raw.githubusercontent.com/moby/moby/master/contrib/download-frozen-image-v2.sh)

The usage syntax for the script is given by the following:

`download-frozen-image-v2.sh target_dir image[:tag][@digest] ...`

The image can then be imported with tar and docker load:

`tar -cC 'target_dir' . | docker load`

### docker with the same UID/GID

[create container with the same UID/GID with HOST](./shell/create_container_with_the_same_uidgid.md)

### docker with vnc

1. [How to make a Docker container with VNC access](https://medium.com/@gustav0.lewin/how-to-make-a-docker-container-with-vnc-access-f607958141ae)
2. create a container for ubuntu 22.04  `docker run -d --security-opt seccomp=unconfined -it --name docker_vnc --privileged -v /dev/bus/usb:/dev/bus/usb -p 5901:5901 -v "$(pwd)/docker_vnc":/app/ vnc_ubuntu`
3. run the container  `docker exec -it -w /app/ docker_vnc /bin/bash`


### [How to move docker data directory to another location on Ubuntu](https://www.guguweb.com/2019/02/07/how-to-move-docker-data-directory-to-another-location-on-ubuntu/)

1. stop the docker daemon

    `sudo service docker stop`

2. add a configutation file *daemon.json* under the `/etc/docker`

```json
    { 
        "data-root": "/path/to/your/docker" 
    }
```

3. copy the current data to the new one

    `sudo rsync -aP /var/lib/docker/ /path/to/your/docker`

4. rename the old docker directory

   `sudo mv /var/lib/docker /var/lib/docker.old`

5. restart the docker daemon

    `sudo service docker start`

6. test, if everything is ok you can remove old one

    `sudo rm -rf /var/lib/docker.old`

7. others

    `/etc/default/docker`

## [crontab](https://opensource.com/article/17/11/how-use-cron-linux)

Edit the crontab: `crontab -e`, the syntax show as below


```sh
┌────────── minute (0 - 59)
 │ ┌──────── hour (0 - 23)
 │ │ ┌────── day of month (1 - 31)
 │ │ │ ┌──── month (1 - 12)
 │ │ │ │ ┌── day of week (0 - 6 => Sunday - Saturday, or
 │ │ │ │ │                1 - 7 => Monday - Sunday)
 ↓ ↓ ↓ ↓ ↓
 * * * * * command to be executed
```
```sh
    :-) Sunday    |    0  ->  Sun
                  |  
        Monday    |    1  ->  Mon
       Tuesday    |    2  ->  Tue
     Wednesday    |    3  ->  Wed
      Thursday    |    4  ->  Thu
        Friday    |    5  ->  Fri
      Saturday    |    6  ->  Sat
                  |  
    :-) Sunday    |    7  ->  Sun
```

* example1 : This line runs mycronjob.sh every Thursday at 3 p.m.


    `00 15 * * Thu /usr/local/bin/mycronjob.sh`

* example2: This cron job runs quarterly reports on the first day of the month after a quarter ends.

    `02 03 1 1,4,7,10 * /usr/local/bin/reports.sh`

* example3: Sometimes you want to run jobs at regular times during normal business hours.

    `01 09-17 * * * /usr/local/bin/hourlyreminder.sh`

* example4: This cron job runs every five minutes during every hour between 8 a.m. and 5:58 p.m. by dividing the hours by the desired interval the expression, */5 in the minutes position means "run the job every 5 minutes."

    `*/5 08-18/2 * * * /usr/local/bin/mycronjob.sh`

* exampe5: shedule to p[aly audio using vlc

```
    0  7 * * * DISPLAY=:0.0 /usr/bin/cvlc --loop --random /home/music_dir
    20 7 * * * usr/bin/killall vlc
```

## Docker Create for VNC

### Dockerfile

```
# Use an official Ubuntu base image
FROM ubuntu:22.04

# Avoid warnings by switching to noninteractive for the build process
ENV DEBIAN_FRONTEND=noninteractive

ENV USER=root

# Install XFCE, VNC server, dbus-x11, and xfonts-base
RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    vim \
    vim-gtk3 \
    dbus-x11 \
    xfonts-base \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# Setup VNC server
RUN mkdir /root/.vnc \
    && echo "password" | vncpasswd -f > /root/.vnc/passwd \
    && chmod 600 /root/.vnc/passwd

# Create an .Xauthority file
RUN touch /root/.Xauthority

# Set display resolution (change as needed)
ENV RESOLUTION=1920x1080

# Expose VNC port
EXPOSE 5901

# Set the working directory in the container
WORKDIR /app

# Copy a script to start the VNC server
COPY start-vnc.sh start-vnc.sh
RUN chmod +x start-vnc.sh

# List the contents of the /app directory
RUN ls -a /app

```

### create `start-vnc.sh`

```
#!/bin/bash

echo 'Updating /etc/hosts file...'
HOSTNAME=$(hostname)
echo "127.0.1.1\t$HOSTNAME" >> /etc/hosts

echo "Starting VNC server at $RESOLUTION..."
vncserver -kill :1 || true
vncserver -geometry $RESOLUTION &

echo "VNC server started at $RESOLUTION! ^-^"

echo "Starting tail -f /dev/null..."
tail -f /dev/null
```

## pip source from aliyun

```
[global]
index-url = https://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
```

or

`-i https://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com`
