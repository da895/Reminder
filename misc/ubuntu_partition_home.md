 Partitioning /Home /Moving
===========================


<!-- vim-markdown-toc GFM -->

* [Overview](#overview)
* [Creating a new partition](#creating-a-new-partition)
  * [Setup Partitions](#setup-partitions)
  * [Find the uuid of the Partition](#find-the-uuid-of-the-partition)
    * [Alternative Method](#alternative-method)
  * [Setup Fstab](#setup-fstab)
  * [Copy /home to the New Partition](#copy-home-to-the-new-partition)
    * [Encrypted file systems](#encrypted-file-systems)
  * [Check Copying Worked](#check-copying-worked)
    * [Encrypted file systems](#encrypted-file-systems-1)
  * [Preparing fstab for the switch](#preparing-fstab-for-the-switch)
  * [Moving /home into /old\_home](#moving-home-into-old_home)
  * [Reboot or Remount all](#reboot-or-remount-all)
    * [Troubleshooting](#troubleshooting)
  * [Deleting the old Home](#deleting-the-old-home)

<!-- vim-markdown-toc -->

Overview 
========

This guide offers detailed instructions for migrating your home
directory into its own dedicated partition. Setting up /home on a
separate partition is beneficial because your settings, files, and
desktop will be maintained if you upgrade, (re)install Ubuntu or another
distro. This works because /home has a subdirectory for each user\'s
settings and files which contain all the data & settings of that user.
Telling Ubuntu to use an existing home partition can be done by
selecting \"Manual Partitioning\" during the installation of Ubuntu and
specifying that you want your home partitions mount point to be /home,
**ensure you mark your /home partition not be formatted in the
process**. You should also make sure the usernames you enter for
accounts during installation match usernames that existed in a previous
installation. 

This guide will follow these 8 basic steps: 

1.  Set-up your new partition 
2.  Find the uuid (=address) of the new partition 
3.  Backup and edit your fstab to mount the new partition as /media/home
    (just for the time being) and reboot. 
4.  Use rsync to migrate all data from /home into /media/home
5.  Check copying worked! 
6.  Move /home to /old\_home to avoid confusion later! 
7.  Edit fstab again so the new partition mounts as /home instead of as
    /media/home 
8.  Reboot or remount all. Check system seems to be working well
9.  Delete the /old\_home after a while 

The guide is written in such a way so that at any point in time if there
is a system failure, power outage or random restart that it will not
have a negative impact on the system and *SHOULD* safeguard against the
possibility of the user accidentally deleting their home directory in
the process. 

Creating a new partition 
========================


Setting up /home on a separate partition is beneficial because your
settings, files, and desktop will be maintained if you upgrade,
(re)install Ubuntu or another distro. This works because /home has a
subdirectory for each user\'s settings and files which contain all the
data & settings of that user. Also, fresh installs for linux typically
like to wipe whatever partition they are being installed to so either
the data & settings need to be backed-up elsewhere or else avoid the
fuss each time by having /home on a different partition. 

Setup Partitions 
----------------


This is beyond the scope of this page. [Try here if you need
help](/community/HowtoPartition). Memorize or write down the location of
the partition, something like /sda3. When you do create a new partition
it is highly suggested that you create an ext3 or ext4 partition to
house your new home directory. 

Find the uuid of the Partition 
------------------------------


The uuid (Universally Unique Identifier) reference for all partitions
can be found by opening a
[command-line](https://help.ubuntu.com/community/UsingTheTerminal#Starting%20a%20Terminal){.https}
to type the following: 

    sudo blkid

### Alternative Method 


For some older releases of Ubuntu the \"blkid\" command might not work
so this could be used instead 

    sudo vol_id -u <partition>


for example 

    sudo vol_id -u /dev/sda3


Now you just need to take note (copy&paste into a text-file) the uuid of
the partition that you have set-up ready to be the new /home partition.

Setup Fstab 
-----------


Your fstab is a file used to tell Ubuntu what partitions to mount at
boot. The following commands will duplicate your current fstab, append
the year-month-day to the end of the file name, compare the two files
and open the original for editing. 

1\. Duplicate your fstab file: 

    sudo cp /etc/fstab /etc/fstab.$(date +%Y-%m-%d)


2\. Compare the two files to confirm the backup matches the original:

    cmp /etc/fstab /etc/fstab.$(date +%Y-%m-%d)


3\. Open the original fstab in a text editor: 

    sudo gedit /etc/fstab 

and add these lines into it 

    # (identifier)  (location, eg sda5)   (format, eg ext3 or ext4)      (some settings) 
    UUID=????????   /media/home    ext3          defaults       0       2 

and replace the \"????????\" with the UUID number of the intended /home
partition.

NOTE: In the above example, the specified partition in the new text is
an ext3, but if yours is an ext4 partition, you should change the part
above that says \"ext3\" to say \"ext4\", in addition to replacing the
???\'s with the correct UUID. Also note that if you are using Kubuntu,
Xubuntu or Lubuntu you may need to replace \"gedit\" with \"kate\",
\"mousepad\" or \"leafpad\", respectively. They are text editors
included with those distributions. 

4\. Save and Close the fstab file, then type the following command:

    sudo mkdir /media/home


This command will create a new directory, later used for temporarily
mounting the new partition. At the end of the procedure this directory
can be removed. 

Now you can restart your machine or instead of rebooting you might
prefer to just re-load the updated fstab 

    sudo mount -a


Either should have mounted the new partition as /media/home. We will
edit the fstab again later so this arrangement of the partition is only
temporary. 

Copy /home to the New Partition 
-------------------------------


Next we will copy all files, directories and sub-directories from your
current /home directory into the new partition. If
you do not have an encrypted home file system, just do the following:


    sudo rsync -aXS --exclude='/*/.gvfs' /home/. /media/home/.

the \"\--excludes\" one - otherwise there is no indication of anything
happening. The \"\--progress\" tag reports on each file individually so
you see tons of unfamiliar stuff scrolling by very fast. Rsync can be
interrupted as many times as you like and it checks to see how much has
already been done when you start it up again. So, this copying stage can
be broken down into many sessions. After it has completed once it\'s
wise to run it a couple more times just to make sure it includes
everything you may have added since first starting the first
copying/syncing session - even if you\'ve done the whole thing all in
just one session. 

The \--exclude=\'/\*/.gvfs\' prevents rsync from complaining about not
being able to copy .gvfs, but I believe it is optional. Even if rsync
complains, it will copy everything else anyway. ([See here for discussion on this](http://ubuntuforums.org/showthread.php?t=791693){.http})

### Encrypted file systems 


If you have an encrypted home file system, then the above will just
leave you with an unencrypted copy of your files, which is probably not what you want. You could re-encrypt them
after copying, or copy them in their encrypted form. 

First, you\'ll need to shut down, and reboot from a LiveCD or USB stick.
Then you\'ll need to mount your root partition and
new home partition. (You can do this by selecting those devices in the
file viewer). They will be mounted under /media/ubuntu - so for example, if you named your root partition
linux-root, then your old home directory will be found at /media/ubuntu/linux-root/home. And if you named your new home
partition linux-home, then this will be found at /media/ubuntu/linux-home. So, now you can copy your encrypted
home files (here assuming your partitions are named
linux-root and linux-home): 


    sudo rsync -aXS /media/ubuntu/linux-root/home/. /media/ubuntu/linux-home/.


There is no point trying to exclude any files with specific names,
because the names of the files are encrypted too! 

Leave your machine running from the LiveCD or USB for the moment.

Check Copying Worked 
--------------------


You should now have two duplicate copies of all the data within your
home directory; the original being located in /home and the new
duplicate located in /media/home. You should confirm all files and
directories copied over successfully. One way to do this (for an
unencrypted file system) is by using the diff command: 


    sudo diff -r /home /media/home -x ".gvfs/*"


If you are doing this from a [LiveCd](/community/LiveCd) or to an
existing partition that already has stuff on it you may find differences
but hopefully it should be obvious which diffs you can ignore.

You can also expect to see some errors about files not found. These are
due to symbolic links that point to places that don\'t presently exist
(but will do after you have rebooted). You can ignore these - but check
out anything else. 

### Encrypted file systems 


If you have an encrypted file system, the command will look more like
this. 

    sudo diff -r /media/ubuntu/linux-root/home /media/ubuntu/linux-home


Now you can shut-down, remove the LiveCD / USB stick, and reboot as
normal. 

Preparing fstab for the switch 
------------------------------


We now need to modify the fstab again to point to the new partition and
mount it as /home. So again on a command-line 

    sudo gedit /etc/fstab


and now edit the lines you added earlier, changing the \"/media/home\"
part to simply say \"/home\" so that it looks like this: 

    # (identifier)  (location, eg sda5)   (format, eg ext3 or ext4)      (some settings) 
    UUID=????????   /home    ext3          defaults       0       2


Then, press Save, close the file but don\'t reboot just yet.

Moving /home into /old\_home 
----------------------------


Backing up your old home, just in case things have not gone completely
smoothly, is best done right now. Here is how: 

As long as you have not rebooted yet, you will still see 2 copies of
your /home directory; the new one on the new partition (currently
mounted as /media/home) and the old one still in the same partition it
was always in (currently mounted as /home). We need to move the contents
of the old home directory out of the way and create an empty
\"place-holder\" directory to act as a \"mount point\" for our new
partition. 

Type the following string of commands in to do all this at once:

    cd / && sudo mv /home /old_home && sudo mkdir /home


By default, when you open a terminal window it places you within your
home directory. Typing cd / takes us to the root directory and out of
home so we can then use the sudo mv command to essentially rename /home
into /old\_home, and finally create a new, empty /home placeholder.
.anchor}

Reboot or Remount all 
---------------------


With; 

1.  your fstab now edited to mount your new partition to our /home
    place-holder and 
2.  the original /home now called /old\_home, 

it should be a good time to reboot your computer to check the whole
thing really did work. Your new partition should mount as /home and
everything should look exactly the same as it did before you started.

Btw, geeks might prefer to avoid rebooting by just re-loading the
updated fstab 

    sudo mount -a


There is no need to reboot - unless you have an encrypted file system.

### Troubleshooting 


If you receive an error like \'The volume may already be mounted\', use
the following command to unmount the drive first before re-doing the
last step again. (note the \"n\" should be missing from the command,
making it \"umount\") 

    sudo umount /media/home/


Then try mounting again 

    sudo mount -a


Deleting the old Home 
---------------------


You can keep using the system as it is for ages before doing this,
unless you are desperately short of space on the / partition. It\'s
probably best to leave this step until a long time after you have been
using the system happily. When you do eventually feel safe enough to
delete the old home then you can try; 

    cd /
    sudo rm -rI /old_home


Be careful with the above command because mis-typing it could result in
the deletion of other files and directories! 

