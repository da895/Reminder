windows上msys2配置及填坑
=======================================================

2018-11-12 (2018-11-10更新)


-   [msys2安装](#msys2安装)
-   [启动msys2](#启动msys2)
-   [msys2中文乱码问题](#msys2中文乱码问题)
-   [MSYS2
    目录映射问题](#msys2-目录映射问题)
    -   [MSYS2 ln
        -s软连接会复制目录的问题](#msys2-ln--s软连接会复制目录的问题)
    -   [fastab配置文件目录的方法](#fastab配置文件目录的方法)
-   [msys2配置国内镜像源](#msys2配置国内镜像源)
-   [更新msys2](#更新msys2)
-   [安装git和vim](#安装git和vim)
-   [安装及配置zsh](#安装及配置zsh)
-   [安装配置conemu](#安装配置conemu)
-   [emacs安装及简单配置](#emacs安装及简单配置)
    -   [\#*\#自动保存文件及*\~备份文件](#自动保存文件及备份文件)
    -   [emacs
        包管理及源设置](#emacs-包管理及源设置)
    -   [emacs安装markdown模式](#emacs安装markdown模式)
-   [编程环境配置](#编程环境配置)
    -   [gcc安装](#gcc安装)
    -   [qt安装](#qt安装)
    -   [pyhon安装](#pyhon安装)
    -   [gcc找不到链接库路径问题](#gcc找不到链接库路径问题)
-   [参考文章](#参考文章)

msys2是一个在windows上模拟linux环境的软件。在msys2上可以使用多数shell命令，现在(2018年)msys2还可以使用pacman安装各种软件和工具，包括emacs，vim，git，
python，qt，mingw-gcc，clang等等。有了msys2可以抛弃虚拟机，在windows使用shell，交叉编译程序了→\_→。

msys2支持linux
shell的常用命令，默认安装了bash、dash等也可以安装zsh。更为方便的是在msys2中，也可以直接运行windows程序，比如notepad,
start命令等等，也能够使用cmd的命令。

### msys2安装

windows上安装msys2非常简单，直接在msys2官网\[<http://msys2.github.io>\]上下载exe安装包，双击运行安装即可。

官网上有两个版本可以下载，分别是32位和64位的。下载32位的即可以在32位windows上安装也可以在64位windows上安装，64位的安装包只能在64位windows上安装。

-   msys2-i686-20180531.exe：32位安装包
-   msys2-x86\_64-20180531.exe：64位安装包

### 启动msys2

msys2安装完成后，开始菜单会有三个启动方式：

-   MSYS2 MSYS
-   MSYS2 MinGW 64bit
-   MSYS2 MINGW 32bit

三种启动方式区别主要在于编译环境软件包的不同，如gcc，clang等版本不同。通用的工具如：grep,git,vim,emacs等等在三种方式内都是一样的。

**运行环境说明：**

为什么要有三个启动方式？如果想知道，需要了解一下mingw编译环境的历史，可以参考大神的文章：\[[MinGW和
MinGW-W64的区别](https://www.jianshu.com/p/adcca97d1962)\]。
本文简单说明一下：

msys2上不支持64bit交叉编译32bit，所以需要独立部署mingw 32bit和mingw
64bit下的开发和运行环境。MSYS上也有一套“编译系统”，三元组是\*-pc-msys。和MinGW相比，MSYS更接近Cygwin（强调POSIX兼容性），提供了一个sysroot（下面有/bin啊/etc什么的），因此移植POSIX环境的程序一般更方便。但是是有代价的。MSYS环境下原生编译的程序一般需要多依赖MSYS运行时库（当然比Cygwin要轻量多了）。所以常规的实践是，如果只是开发Windows程序，能用MinGW就不要用MSYS原生的编译器来构建。当然，使用MSYS上的sh等工具还是没问题，跟GNU工具配套怎么说比cmd总好用。（虽然也有不少琐碎坑爹bug。）

所以个人大多数时间使用MSYS2 MinGW 64bit。

MSYS2三个启动方式都是从msys2\_shell.cmd脚本启动的，三个启动方式在脚本内仅仅在于为变量MSYSTEM设置了不同的值

-   MSYS2 MSYS：`set MSYSTEM=MSYS`
-   MSYS2 MinGW 32bit：`set MSYSTEM=MINGW32`
-   MSYS2 MinGW 64bit：`set MSYSTEM=MINGW64`

从etc/profile和etc/msystem配置文件可以看出。设置了MSYSTEM变量后，三种启动方式分别从opt/bin,mingw32/bin,mingw64/bin文件夹内查找开发和运行环境软件包。通用的工具如：grep,git,vim,emacs等等都安装在/usr/bin内，三个方式都可以调用。

所以启动Msys2，除了可以通过点击开始菜单的快捷方式，还可以用下述命令启动（平常没必要，但是可以用于设置conemu等虚拟终端）：


msys2中文乱码问题
-----------------

目前(2018年)msys2对中文支持已经非常好了。但是还是有少部分命令出现问题，比如msys2
ping中文会显示乱码：

``` {.highlight}
$ ping baidu.com

▒▒▒▒ Ping baidu.com [220.181.57.217] ▒▒▒▒ 32 ▒ֽڵ▒▒▒▒▒:
▒▒▒▒ 220.181.57.217 ▒Ļظ▒: ▒ֽ▒=32 ʱ▒▒=19ms TTL=55
▒▒▒▒ 220.181.57.217 ▒Ļظ▒: ▒ֽ▒=32 ʱ▒▒=19ms TTL=55
▒▒▒▒ 220.181.57.217 ▒Ļظ▒: ▒ֽ▒=32 ʱ▒▒=19ms TTL=55
▒▒▒▒ 220.181.57.217 ▒Ļظ▒: ▒ֽ▒=32 ʱ▒▒=19ms TTL=55

220.181.57.217 ▒▒ Ping ͳ▒▒▒▒Ϣ:
    ▒▒▒ݰ▒: ▒ѷ▒▒▒ = 4▒▒▒ѽ▒▒▒ = 4▒▒▒▒ʧ = 0 (0% ▒▒ʧ)▒▒
▒▒▒▒▒г̵Ĺ▒▒▒ʱ▒▒(▒Ժ▒▒▒Ϊ▒▒λ):
    ▒▒▒ = 19ms▒▒▒ = 19ms▒▒ƽ▒▒ = 19ms
```

出现这个问题的命令很少，但是还是很影响心情。

**解决方法**

新建/bin/win文件，文件内容如下：

> PS：msys2中根目录/默认为msys2安装地址C:/msys2。


``` {.highlight}
#!usr/bin/bash
$@ |iconv -f gbk -t utf-8
```


新建/etc/profile.d/alias.sh文件，文件内容如下：

``` {.highlight}
alias ls="/bin/ls --color=tty --show-control-chars"
alias grep="/bin/grep --color"
alias ll="/bin/ls --color=tty --show-control-chars -l"
 
alias ping="/bin/win ping"
alias netstat="/bin/win netstat"
alias nslookup="/bin/win nslookup"
```

重新启动msys2后效果：

``` {.highlight}
$ ping baidu.com

正在 Ping baidu.com [220.181.57.217] 具有 32 字节的数据:
来自 220.181.57.217 的回复: 字节=32 时间=19ms TTL=55
来自 220.181.57.217 的回复: 字节=32 时间=19ms TTL=55
来自 220.181.57.217 的回复: 字节=32 时间=19ms TTL=55
来自 220.181.57.217 的回复: 字节=32 时间=19ms TTL=55

220.181.57.217 的 Ping 统计信息:
    数据包: 已发送 = 4，已接收 = 4，丢失 = 0 (0% 丢失)，
往返行程的估计时间(以毫秒为单位):
    最短 = 19ms，最长 = 19ms，平均 = 19ms
```

> 当然，不使用上述解决方法，使用conemu虚拟终端就不存在这个问题。

MSYS2 目录映射问题
------------------

### MSYS2 ln -s软连接会复制目录的问题

MSYS2在windows上用ln -s dir创建软连接时，会复制所有文件到目标文件夹。

解决这个问题需要在`/etc/profile`文件里面加上一个关键变量：

``` {.highlight}
export MSYS="winsymlinks:lnk"
```

添加后创建的目录软连接，就和linux上很类似了。直接cd就能进入被连接的目录文件夹，非常方便。

### fastab配置文件目录的方法

在fstab中配置也可以映射目录，个人更喜欢用ln -s软连接。

在/etc/fstab配置文件目录映射的方法：

直接在/etc/fstab后加入如下代码，然后重启msys2就可以了

``` {.highlight}
C:\Users\adminstrator\Desktop /desktop
#目录路径中不能有空格。如果目录路径中有空格请使用转义字符"\040"代替
```

上述命令配置完成后，在终端cd
\\/desktop后可以直接切换到C:\\Users\\adminstrator\\Desktop目录下。

msys2配置国内镜像源
-------------------

用pacman命令安装软件会先从默认的源上下载软件，pacman默认使用SF的源，但是在国内有时候会不太稳定，所以可以选择添加国内的源。比如：

-   [中国科学技术开源软件镜像](http://mirrors.ustc.edu.cn/msys2/)
-   [北京理工大学镜像](http://mirror.bit.edu.cn/msys2/REPOS/MSYS2/)
-   [日本北陆先端科学技术大学院大学SourceForge镜像](http://jaist.dl.sourceforge.net/project/msys2/REPOS/MSYS2/)
-   [The UK Mirror Service Sorceforge
    mirror](http://www.mirrorservice.org/sites/download.sourceforge.net/pub/sourceforge/m/ms/msys2/REPOS/MSYS2/)

方法：修改msys2安装目录下的\\etc\\pacman.d文件夹里面的3个mirrorlist.\*文件。

个人目前用的源配置如下：

mirrorlist.mingw32文件

``` {.highlight}
## 2-bit Mingw-w64 repository mirrorlist
## Primary
Server = http://mirrors.ustc.edu.cn/msys2/mingw/i686/
Server = http://repo.msys2.org/mingw/i686
Server = http://downloads.sourceforge.net/project/msys2/REPOS/MINGW/i686
Server = http://www2.futureware.at/~nickoe/msys2-mirror/i686/
```

mirrorlist.mingw64文件

``` {.highlight}
## 64-bit Mingw-w64 repository mirrorlist
## Primary
Server = http://mirrors.ustc.edu.cn/msys2/mingw/x86_64/
Server = http://repo.msys2.org/mingw/x86_64
Server = http://downloads.sourceforge.net/project/msys2/REPOS/MINGW/x86_64
Server = http://www2.futureware.at/~nickoe/msys2-mirror/x86_64/
Server = http://mirror.bit.edu.cn/msys2/REPOS/
```

mirrorlist.msys文件

``` {.highlight}
## MSYS2 repository mirrorlist
## Primary
Server = http://mirrors.ustc.edu.cn/msys2/msys/$arch/
Server = http://repo.msys2.org/msys/$arch
Server = http://downloads.sourceforge.net/project/msys2/REPOS/MSYS2/$arch
Server = http://www2.futureware.at/~nickoe/msys2-mirror/msys/$arch/
```

更新msys2
---------

msys2自带有pacman管理和安装软件，类似ubuntu中的apt-get。pacman下载后的软件包默认存放目录msys64\\var\\cache\\pacman\\pkg。使用pacman可以用一个命令升级系统及所有已安装的软件。

``` {.highlight}
pacman -Syu
```

之后需要关闭所有MSYS2 shell，然后运行msys2根目录下autorebase.bat

> pacman是从Arch
> linux移植过来的，pacman只支持系统完整升级，不支持部分升级。所以即使在msys2中，pacman
> -Syu也会升级整个系统。

如果升级时，网络比较慢，觉得既浪费时间又浪费硬盘，实在不想升级那么多东西，可以逐个软件包升级。用下面命令可以升级核心包：

``` {.highlight}
#同步数据库
pacman -Sy
#安装核心包
pacman -S --needed filesystem msys2-runtime bash libreadline libiconv libarchive libgpgme libcurl pacman ncurses libintl
#升级其他软件包
pacman -Su
```

安装git和vim
------------

``` {.highlight}
pacman -S git
```

msys2中，git依赖curl,vim,perl，所以安装git后，自动会安装好vim。

**git 中文显示数字问题**

git中如果存在中文文件名，则会显示为\\232\\333这种形式，特别不方便，并且文件名变的特别长。

解决办法：

``` {.highlight}
git config --global core.quotepath false
```

安装及配置zsh
-------------

shell的类型有很多种，linux下默认的是bash，虽然bash的功能已经很强大，但对于以懒惰为美德的程序员来说，bash的提示功能不够强大，界面也不够炫，并非理想工具。
而zsh的功能极其强大，只是配置过于复杂，起初只有极客才在用。后来，有个穷极无聊的程序员可能是实在看不下去广大猿友一直只能使用单调的bash,
于是他创建了一个名为[oh-my-zsh的开源项目](https://github.com/robbyrussell/oh-my-zsh)
。自此，只需要简单的安装配置，小白程序员们都可以用上高档大气上档次的zsh。

查看msys2是否安装了zsh

``` {.highlight}
cat /etc/shells
```

安装zsh

``` {.highlight}
pacman -S zsh
```

**安装 oh my zsh**

\[[oh-my-zsh](https://ohmyz.sh/)\]源码是放在github上，先确保你的机器上已安装了git

安装：

``` {.highlight}
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

或者

``` {.highlight}
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
```

\*\* 配置zsh为msys2默认shell\*\*

msys2
不支持chsh命令修改默认shell。所以要么每次进入后直接用zsh切换到zsh，要么就修改msys2\_shell。cmd文件。

在msys2的安装目录(c:\\msys64)下打开msys2\_shell.cmd文件。修改文件中LOGINSHELL变量如下：

set “LOGINSHELL=zsh”

重启msys2就默认使用zsh了。

**zsh主题选择**

oh-my-zsh有很多漂亮的主题，https://github.com/robbyrussell/oh-my-zsh/wiki/themes
上面可以查看主题列表。

国内比较流行的主题是ys，配置ys主题的方法为：

``` {.highlight}
$ vim ~/.zshrc
ZSH_THEME="ys"      #修改.zshrc中ZSH_THEME的值为ys
$ source ~/.zshrc   #更新配置
```

\*\* zsh自动补齐插件\*\*

zsh的自动补全功能已经非常强大了，但是zsh的incr.zsh自动补全插件功能更强，可以在你输入命令的过程中用灰色显示推断的后续命令。

``` {.highlight}
##下载插件
wget http://mimosa-pudica.net/src/incr-0.2.zsh
##将此插件放到oh-my-zsh目录的插件库下
mkdir ~/.oh-my-zsh/plugins/incr
mv incr-0.2.zsh ~/.oh-my-zsh/plugins/incr
```

在\~/.zshrc文件末尾加上`source ~/.oh-my-zsh/plugins/incr/incr\*.zsh`，然后更新配置

``` {.highlight}
##shell中运行该命令更新配置
source ~/.zshrc
```

\*\* incr.zsh与vim的提示相冲突的解决方案\*\*

使用自动补全插件可能会与vim的提示功能相冲突，如会报以下错误：

``` {.highlight}
$ vim t
_arguments:451: _vim_files: function definition file not found
```

解决方法：将`~/.zcompdump*`删除即可

``` {.highlight}
rm -rf ~/.zcompdump*
exec zsh
```

\*\* zsh在使用git命令卡顿的问题\*\*

在 oh-my-zsh 进入 包含 git 仓库目录时，会变的比平时慢/卡顿，原因是因为
oh-my-zsh 要获取 git 更新信息。

解决办法：

``` {.highlight}
##设置 oh-my-zsh 不读取文件变化信息（在 git 项目目录执行下列命令）
git config --add oh-my-zsh.hide-dirty 1
##如果你还觉得慢，可以再设置 oh-my-zsh 不读取任何 git 信息
git config --add oh-my-zsh.hide-status 1
```

okey 了，如果想恢复，设置成0就好

安装配置conemu
--------------

conemu作为虚拟终端比msys2默认的mintty要好用。所以喜欢的同学可以使用conemu。

目前(2018年)msys2中用pacman
-S安装的conemu在汉字支持上有些bug。所以建议直接从conemu官网下载。

ConEmu官网下载地址：<https://conemu.github.io/>

以MSYS2 MingGW64为例，配置MSYS2任务：

1.  打开conemu的settings对话框
2.  选择Startup»Tasks选项
3.  点击+号，新建一个Task
4.  修改Task名字为MSYS2::MingGW64
5.  在commands下文本框内输入如下代码：

``` {.highlight}
set MSYS2_PATH_TYPE=inherit & set MSYSTEM=mingw64 & set "D=C:\msys64" & %D%\usr\bin\bash --login -i -new_console:C:"%D%\msys2.ico"
```

MSYS2\_PATH\_TYPE=inherit表示合并windows系统的path变量。

> 如果安装了zsh并想默认使用zsh可以，把代码里的bash改为zsh
>
> mingw32模式只需修改代码中的MSYSTEM=mingw32即可，msys模式修改为MSYSTEM=msys

conemu有很多配置，如果需要配置更多选项，可以查看本站conemu配置相关文章。

emacs安装及简单配置
-------------------

``` {.highlight}
pacman -S emacs
```

**emacs windows上中文问题及-nw问题**

如果在windows下，直接下载安装emacs，即使使用emacs
-nw命令也只能显示GUI界面，没法在命令行模式下打开。此外，中文输入也存在问题，只能使用emacs内部的输入法，非常不方便。msys2里用pacman
-S安装的emacs则不存在这些问题。

所以，在windows下使用emacs建议最好用msys2的pacman安装。

### \#*\#自动保存文件及*\~备份文件

emacs总是会产生一堆file\~文件和\#file\#文件，这都是什么文件呢，其实是自动备份和自动保存文件。

emacs保存文件的时候，会把上次保存的文件file修改为file\~，然后再保存在file里。file\~就是自动备份文件，用于防止文件损坏或丢失。

Emacs还有自动保存的功能，当你改动了一个文件还未存盘的话，所作的改动也许会由于系统崩溃而丢失。为防止这种情况发生，Emacs在编辑时为每个文件提供了“自动保存(auto
save)”。自动保存的文件的文件名前后都有一个\#号。例如，如果你编辑的文件名叫“hello.c”，自动保存的文件的文件名就叫
“\#hello.c\#”。当你正常的保存了文件后，Emacs会删除这个自动保存的文件。如果遇到死机，打开文件（是你编辑的文件而不是自动保存的文件）后按M-x
recover file 来恢复你的编辑。当提示确认时，输入yes
来继续恢复自动保存的数据。

如果不喜欢emacs的自动备份和自动保存文件，可以通过下面方法关闭：

在\~/.emacs: 中添加

``` {.highlight}
(setq auto-save-default nil)   #关闭自动保存
(setq make-backup-files nil)   #关闭自动备份
```

对于自动保存文件\#file\#,用下面方式把自动保存文件统一放在指定的文件夹下：

在\~/.emacs: 中添加下面的lisp语句

``` {.highlight}
(setq backup-directory-alist '(("" . "~/bak/")))
```

### emacs 包管理及源设置

**查看package列表及安装包**

方法一：

-   M-X list-packages 查看安装好的和可以安装的包。
-   C-n、C-p、C-v上下移动光标，或者按C-s搜索包
-   在对应的软件包上回车，可以查看软件包信息
-   按下 i 键，将其标记为待安装的
-   按下 u 键，取消标记
-   按下 d 键，标记为待卸载的
-   然后按 x 键执行标记的项目。
-   按下 q 建，退出package列表

方法二：

使用M-x package-install命令也安装包

**源配置**

-   在\~/.emacs文件中添加：`(package-initialize)`。启动时加载安装的扩展
-   在\~/.emacs文件中添加: `(require 'package)`。否则后边的package命令无法执行
-   查看package源：`C-h v package-archives`
-   添加package源:
    `M-x customize-variable RET package-archives`
    -   选择 INS 回车，可以添加package源，例如：

    ``` {.highlight}
      name:  melpa
      URL: https://melpa.org/packages/
    ```

-   强制刷新packages：`M-x package-refresh-contents`。PS：刷新过程可能会有点慢，可以切换到其他文件先做别的事。

刷新后查看package，会比之前的多出来许多。

### emacs安装markdown模式

-   使用M-X list-packages 进入package列表，如果已在这个界面，按 r
    键刷新。
-   C-n、C-p移动光标，或者按C-s搜索“markdown”
-   将光标置于“markdown-mode”那行
-   按下 i 键，将其标记为待安装的，然后按 x 键执行标记为 i
    的待安装的项目。
-   按下 q 建，退出package列表

然后每次打开markdown文件就会自动切换到markdown模式，当然也可以用M-x
markdown-mode手动切换。

编程环境配置
------------

### gcc安装

随便哪个msys2启动方式都可以，只是安装好后，只能在对应的环境下运行。

1.  查看可用的安装包

  ---------------------------------------------------------------------------- ----------
  `pacman -Ssq gcc` \#或者`pacman -Sl   grep gcc`
  ---------------------------------------------------------------------------- ----------

可以看到以下三个

-   mingw32 mingw-w64-i686-gcc
-   mingw64 mingw-w64-x86\_64-gcc
-   msys gcc

分别对应于 msys 的三个环境。这里安装64位版本，其他类似。

1.  安装

pacman -S mingw-w64-x86\_64-gcc

不论你在哪个环境下安装，MSYS2 都会自动将这个包装在 msys64/mingw64
下。从之前的分析可知只有在 mingw64
环境下才能使用这个目录下的程序。在其他两个环境下虽然能够安装mingw-w64-x86\_64-gcc，但是不能使用mingw-w64-x86\_64-gcc。

1.  运行

使用MinGW 64bit方式进入MSYS2：

``` {.highlight}
gcc --version
gcc.exe (Rev3, Built by MSYS2 project) 4.9.1
Copyright (C) 2014 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR P
```

### qt安装

qt类似，我们选择安装mingw-w64-x86\_64-qt5。

pacman -S mingw-w64-x86\_64-qt5

qt安装后非常大，如果需要，请谨慎安装。

### pyhon安装

python对windows的支持很好，并且即使下载windows版安装包安装后，在msys2里也能调用，所以不想折腾就直接用windows版本的python吧。

### gcc找不到链接库路径问题

在pacman中安装了SDL等库，但是gcc链接的时候就是提示找不到sdl。

解决方法：在msys2\_shell.cmd中加入如下代码

``` {.highlight}
set LIBRARY_PATH=C:\msys64\mingw64\lib
```

> 在shell里使用LIBRARY\_PATH=/mingw64/lib是不行的

参考文章
--------

-   [MSYS2](http://www.rswiki.org/%E7%A8%8B%E5%BA%8F%E8%AE%BE%E8%AE%A1/msys2?rev=1416044574)
-   [msys2使用小结](http://www.annhe.net/article-3482.html)
-   [MinGW和 MinGW-W64的区别](https://www.jianshu.com/p/adcca97d1962)
-   [MSYS2 + MinGW-w64 + Git + gVim
    环境配置](https://blog.csdn.net/longfeey/article/details/52014608)
-   [oh-my-zsh git
    慢/卡顿问题解决](https://blog.csdn.net/weixin_41282397/article/details/84291907)
-   [是否需要花哨的命令提示符](https://zhuanlan.zhihu.com/p/51008087)
-   [MSYS2开发环境搭建](http://blog.csdn.net/callinglove/article/details/48601775)
-   [emacs
    产生的*\~和\#*\#文件](https://blog.csdn.net/G1036583997/article/details/50766421)
-   [vi/emacs编辑文件生成的\#filename\#
    或者filename\~能否指定到某一个位置](https://bbs.csdn.net/topics/60467594)
-   [emacs学习笔记（package列表查看&添加packages源&安装packages）](https://blog.csdn.net/mathadora/article/details/79463046)
