#!/usr/bin/bash

HOSTUID=$(id -u)
HOSTGID=$(id -g)
HOSTNAME=$USER

IMAGE_NAME=ubuntu_2004_toolchain

CONTAINER_CFG=container_cfg
ENTRYPOINT_FILE=entrypoint.sh
TOOLCHAIN_ENV=custom.sh
FILE_VIMRC=vimrc.local
FILE_VNC=start_vnc.sh
FILE_XSTARTUP=xstartup
TOOLCHAIN_RISCV_LOC=toolchains/riscv32-embecosm-ubuntu2004-gcc13.2.0.zip
TOOLCHAIN_ARM_LOC=toolchains/gcc-arm-none-eabi-9-2019-q4-major.zip
TOOLCHAIN_BA_LOC=toolchains/ba-elf-new_4_7_3.zip
TOOLCHAIN_BA1_LOC=toolchains/ba-elf-ov494_4_9_1.zip
TOOLCHAIN_ARM1_LOC=toolchains/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.zip



TOOLCHAIN_BA=$(basename -- $TOOLCHAIN_BA_LOC)
TOOLCHAIN_ARM=$(basename -- $TOOLCHAIN_ARM_LOC)
TOOLCHAIN_RISCV=$(basename -- $TOOLCHAIN_RISCV_LOC)


TOOL_BA_NAME=${TOOLCHAIN_BA%.zip}
TOOL_RISCV_NAME=${TOOLCHAIN_RISCV%.zip}
TOOL_AMR_NAME=${TOOLCHAIN_ARM%.zip}

print_err ()
{
  echo -e "\033[31;1m$1, please type $0 -h for help\033[0m"
  exit
}

print_warn ()
{
   echo -e "\033[34;1m$1\033[0m" 
}


GEN_HOST_INFO ()
{
  echo "HOST_UID=$HOSTUID" >.env
  echo "HOST_GID=$HOSTGID" >>.env
  echo "HOST_NAME=$HOSTNAME" >>.env
}

GEN_VIMRC ()
{
  DOC_VIMRC=`cat <<VIMRCFILE
:syntax enable
syntax on
:colorscheme darkblue
set ruler
set hlsearch
set incsearch
set expandtab
set shiftwidth=2
set softtabstop=2
VIMRCFILE`
echo "$DOC_VIMRC" | sed -e "s/#/\$/g" > $FILE_VIMRC
}

GEN_TOOLCHAIN_ENV ()
{
  ADD_ENV=`cat <<ADD_ENV_FILE
[ -n "#BASH_VERSION" -o -n "#ZSH_VERSION" ] || return 0

alias fd='find . -name'
alias g='vim'
alias gv='vim'
alias sc='source ~/.bashrc'
alias du1='du --max-depth=1 -h'

export PATH="/opt/${TOOL_BA_NAME}/bin:#{PATH}" 
export PATH="/opt/${TOOL_AMR_NAME}/bin:#{PATH}" 
export PATH="/opt/${TOOL_RISCV_NAME}/bin:#{PATH}" 

ADD_ENV_FILE` 
echo "$ADD_ENV" | sed -e "s/#/\$/g" > $TOOLCHAIN_ENV
}

GEN_DOCKERFILES ()
{
  
    DOC_DOCKERFILE=`cat <<DOCKER_FILES
FROM ubuntu:20.04


ARG USER=root

RUN echo 'root:password' | chpasswd

RUN dpkg --add-architecture i386

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y sudo --no-install-recommends\
        vim-gtk3 aria2 curl python-is-python3 vim git universal-ctags zip unzip\
         libc6:i386 libstdc++6:i386 build-essential cmake \
        xfce4 xfce4-goodies tightvncserver dbus-x11 xfonts-base \
        ca-certificates openssl\
        locales xfonts-intl-chinese\
        fcitx fcitx-config-gtk fcitx-googlepinyin\
        fonts-wqy-zenhei fonts-wqy-microhei\
        language-pack-zh-hans language-pack-gnome-zh-hans\
        && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN groupadd -r mygroup --gid 9999 && \
    useradd -rmg mygroup --uid 9999 docker_user && \
    echo "docker_user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY entrypoint.sh /etc/entrypoint.sh
COPY ${TOOLCHAIN_BA_LOC} /opt/
COPY ${TOOLCHAIN_ARM_LOC} /opt/
COPY ${TOOLCHAIN_RISCV_LOC}  /opt/
COPY ${TOOLCHAIN_BA1_LOC}  /opt/
COPY ${TOOLCHAIN_ARM1_LOC}  /opt/


RUN chmod +x /etc/entrypoint.sh
RUN unzip -q /opt/${TOOLCHAIN_ARM} -d /opt/
RUN unzip -q /opt/${TOOLCHAIN_BA} -d /opt/
RUN unzip -q /opt/${TOOLCHAIN_RISCV} -d /opt/

RUN rm /opt/${TOOLCHAIN_RISCV} 
RUN rm /opt/${TOOLCHAIN_BA}
RUN rm /opt/${TOOLCHAIN_ARM}

RUN mkdir /home/docker_user/.vnc \
    && echo "password" | vncpasswd -f > /home/docker_user/.vnc/passwd \
    && chmod 600 /home/docker_user/.vnc/passwd
RUN touch /home/docker_user/.Xauthority
RUN echo "export RESOLUTION=1920x1080" >>/home/docker_user/.bashrc

COPY $TOOLCHAIN_ENV /etc/profile.d/
COPY $FILE_VIMRC /etc/vim/
COPY $FILE_VNC  /etc/
COPY $FILE_XSTARTUP /home/docker_user/.vnc/
RUN chmod +x /etc/$FILE_VNC
RUN chmod +x /home/docker_user/.vnc/$FILE_XSTARTUP

RUN echo "source /etc/profile.d/$TOOLCHAIN_ENV" >>/home/docker_user/.bashrc

ENTRYPOINT ["/etc/entrypoint.sh"]
CMD ["bash"]

DOCKER_FILES`
echo "$DOC_DOCKERFILE" | sed -e "s/#/\$/g" > $CONTAINER_CFG

#RUN echo "source /etc/$FILE_VNC"  >>/home/docker_user/.bashrc
}


GEN_ENTRYPOINT ()
{
  DOC_ENTRYPOINT=`cat <<ENTRYPOINT
#!/usr/bin/bash
USER_ID=|_|{HOST_UID:-9999}
GROUP_ID=|_|{HOST_GID:-9999}

sudo groupmod -g |_|GROUP_ID mygroup
sudo usermod -u |_|USER_ID -g |_|GROUP_ID docker_user
sudo chown -R |_|USER_ID:|_|GROUP_ID /home/docker_user

exec sudo -u docker_user "|_|@"
mkdir -p /home/docker_user/workspace


ENTRYPOINT`
echo "$DOC_ENTRYPOINT" | sed -e "s/|_|/\$/g" > $ENTRYPOINT_FILE
}

GEN_START_VNC ()
{
  DOC_VNC=`cat <<VNCFILE
#!/bin/bash

HOSTNAME=|_|(hostname)
echo "127.0.1.1\t|_|HOSTNAME" >> /etc/hosts

vncserver -kill :1 || true
vncserver :1 -geometry |_|RESOLUTION &


VNCFILE`
echo "$DOC_VNC" | sed -e "s/|_|/\$/g" > $FILE_VNC
}

GEN_XSTARTUP ()
{
  DOC_XSTARTUP=`cat <<XSTARTUP

unset DBUS_SESSION_BUS_ADDRESS
export XKL_XMODMAP_DISABLE=1
startxfce4 &

XSTARTUP`
echo "$DOC_XSTARTUP" | sed -e "s/#/\$/g" > $FILE_XSTARTUP
}

BUILD_CONTAINER ()
{
  
  TMP_DIR=$PWD/test  
  rm -rf $TMP_DIR
  mkdir -p $TMP_DIR
  cp -f $CONTAINER_CFG $TMP_DIR/dockerfile
  cp -f $ENTRYPOINT_FILE $TMP_DIR/
  cp -f .env $TMP_DIR
  cp -f $TOOLCHAIN_ENV $TMP_DIR
  cp -f $FILE_VIMRC $TMP_DIR
  cp -f $FILE_VNC   $TMP_DIR
  cp -f $FILE_XSTARTUP $TMP_DIR
  cp -rf toolchains $TMP_DIR

  docker build -t $IMAGE_NAME $TMP_DIR
}

RUN_CONTAINER()
{
  docker run -it --rm --env-file .env -v $TMP_DIR:/home/docker_user/workspace $IMAGE_NAME
}

CREATE_CONTAINER_DAEMON()
{
  docker run -d -it --env-file .env --name $container_name -w /home/docker_user/workspace -v $TMP_DIR:/home/docker_user/workspace $IMAGE_NAME
}

RUN_CONTAINER_DAEMON()
{
  docker exec -it -u docker_user $container_name /bin/bash
}

GEN_HOST_INFO
GEN_VIMRC
GEN_START_VNC
GEN_XSTARTUP
GEN_TOOLCHAIN_ENV
GEN_ENTRYPOINT
GEN_DOCKERFILES
BUILD_CONTAINER
#RUN_CONTAINER

