#!/usr/bin/bash

HOSTUID=$(id -u)
HOSTGID=$(id -g)
HOSTNAME=$USER

IMAGE_NAME=sigrok-mxe-2204-w64

CONTAINER_CFG=container_cfg
ENTRYPOINT_FILE=entrypoint.sh
TOOLCHAIN_ENV=custom.sh
FILE_VIMRC=vimrc.local
TMP_DIR=$PWD/test  
container_name=mex-test


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


ADD_ENV_FILE` 
echo "$ADD_ENV" | sed -e "s/#/\$/g" > $TOOLCHAIN_ENV
}

#ENV MXE_TARGETS "i686-w64-mingw32.static.posix x86_64-w64-mingw32.static.posix"
GEN_DOCKERFILES ()
{
  
    DOC_DOCKERFILE=`cat <<DOCKER_FILES

FROM ubuntu:22.04 AS sigrok-mxe
LABEL \
	org.opencontainers.image.title="sigrok MXE Build Image" \	
	org.opencontainers.image.description="This image is used to cross compile the sigrok artifacts for Windows with MXE" \
	org.opencontainers.image.url="https://sigrok.org" \
	org.opencontainers.image.source="https://github.com/sigrokproject/sigrok-build" \
	org.opencontainers.image.licenses="GPL-3.0-or-later" \
	org.opencontainers.image.authors="Soeren Apel <sigrok@apelpie.net>, Frank Stettner <frank-stettner@gmx.net>" \
	maintainer="Soeren Apel <sigrok@apelpie.net>"

ARG USER=root

RUN echo 'root:password' | chpasswd

ARG DEBIAN_FRONTEND=noninteractive

ENV BASE_DIR=/opt
ENV MXE_DIR=#BASE_DIR/mxe
ENV MXE_TARGETS="x86_64-w64-mingw32.static.posix"
ENV MXE_PLUGIN_DIRS="plugins/examples/qt5-freeze"

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y --no-install-recommends \
		sudo \
		autoconf \
		automake \
		autopoint \
		bash \
		bison \
		bzip2 \
		flex \
		g++ \
		sdcc \
		gettext \
		gperf \
		gtk-doc-tools \
		intltool \
		libgdk-pixbuf2.0-dev \
		libltdl-dev \
		libssl-dev \
		libtool-bin \
		libxml-parser-perl \
		lzip \
		make \
        vim-gtk3 aria2 curl python-is-python3 vim git universal-ctags zip unzip\
        ca-certificates openssl\
		p7zip-full \
		patch \
		perl \
		pkg-config \
		python3 \
		ruby \
		sed \
		zip unzip \
		wget \
		xz-utils \
		doxygen \
		nsis asciidoctor \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*


RUN groupadd -r mygroup --gid 9999 && \
    useradd -rmg mygroup --uid 9999 sigrok-mxe && \
    echo "sigrok-mxe ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh
COPY $FILE_VIMRC /etc/vim/

WORKDIR #BASE_DIR
COPY mxe_fixes.patch #BASE_DIR
RUN git clone https://github.com/mxe/mxe.git #MXE_DIR \
	&& cd #MXE_DIR \
	&& git reset --hard b48b3cc7085548e896fe967dc6371ff9951390a4 \
	&& patch -p1 < #BASE_DIR/mxe_fixes.patch

RUN cd #MXE_DIR && make -j#(nproc) MXE_USE_CCACHE= DONT_CHECK_REQUIREMENTS=1 MXE_TARGETS="#MXE_TARGETS" MXE_PLUGIN_DIRS="#MXE_PLUGIN_DIRS" gcc
RUN cd #MXE_DIR && make -j#(nproc) MXE_USE_CCACHE= DONT_CHECK_REQUIREMENTS=1 MXE_TARGETS="#MXE_TARGETS" MXE_PLUGIN_DIRS="#MXE_PLUGIN_DIRS" glib
RUN cd #MXE_DIR && make -j#(nproc) MXE_USE_CCACHE= DONT_CHECK_REQUIREMENTS=1 MXE_TARGETS="#MXE_TARGETS" MXE_PLUGIN_DIRS="#MXE_PLUGIN_DIRS" \
		libzip \
		libusb1 \
		libftdi1

COPY hidapi_fixes.patch #BASE_DIR
RUN cd #MXE_DIR && patch -p1 < #BASE_DIR/hidapi_fixes.patch
RUN cd #MXE_DIR && make -j#(nproc) MXE_USE_CCACHE= DONT_CHECK_REQUIREMENTS=1 MXE_TARGETS="#MXE_TARGETS" MXE_PLUGIN_DIRS="#MXE_PLUGIN_DIRS" hidapi

RUN cd #MXE_DIR && make -j#(nproc) MXE_USE_CCACHE= DONT_CHECK_REQUIREMENTS=1 MXE_TARGETS="#MXE_TARGETS" MXE_PLUGIN_DIRS="#MXE_PLUGIN_DIRS" glibmm

RUN cd #MXE_DIR && make -j#(nproc) MXE_USE_CCACHE= DONT_CHECK_REQUIREMENTS=1 MXE_TARGETS="#MXE_TARGETS" MXE_PLUGIN_DIRS="#MXE_PLUGIN_DIRS" \
		qtbase \
		qtimageformats
RUN cd #MXE_DIR && make -j#(nproc) MXE_USE_CCACHE= DONT_CHECK_REQUIREMENTS=1 MXE_TARGETS="#MXE_TARGETS" MXE_PLUGIN_DIRS="#MXE_PLUGIN_DIRS" \
		qtsvg \
		qttools \
		qttranslations
RUN cd #MXE_DIR && make -j#(nproc) MXE_USE_CCACHE= DONT_CHECK_REQUIREMENTS=1 MXE_TARGETS="#MXE_TARGETS" MXE_PLUGIN_DIRS="#MXE_PLUGIN_DIRS" boost
RUN cd #MXE_DIR && make -j#(nproc) MXE_USE_CCACHE= DONT_CHECK_REQUIREMENTS=1 MXE_TARGETS="#MXE_TARGETS" MXE_PLUGIN_DIRS="#MXE_PLUGIN_DIRS" \
		check \
		gendef \
		libieee1284 \
		nettle \
		qwt \
		qtbase_CONFIGURE_OPTS='-no-sql-mysql'

RUN rm -rf #MXE_DIR/.log \
	&& rm -rf #MXE_DIR/mxe/pkg

ENTRYPOINT ["/etc/entrypoint.sh"]
CMD ["bash"]

DOCKER_FILES`
echo "$DOC_DOCKERFILE" | sed -e "s/#/\$/g" > $CONTAINER_CFG

#RUN echo "source /etc/$FILE_VNC"  >>/home/sigrok-mxe/.bashrc
}


GEN_ENTRYPOINT ()
{
  DOC_ENTRYPOINT=`cat <<ENTRYPOINT
#!/usr/bin/bash
USER_ID=|_|{HOST_UID:-9999}
GROUP_ID=|_|{HOST_GID:-9999}

sudo groupmod -g |_|GROUP_ID mygroup
sudo usermod -u |_|USER_ID -g |_|GROUP_ID sigrok-mxe
sudo chown -R |_|USER_ID:|_|GROUP_ID /home/sigrok-mxe

exec sudo -u sigrok-mxe "|_|@"
mkdir -p /home/sigrok-mxe/workspace


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
  
  rm -rf $TMP_DIR
  mkdir -p $TMP_DIR
  cp -f $CONTAINER_CFG $TMP_DIR/dockerfile
  cp -f $ENTRYPOINT_FILE $TMP_DIR/
  cp -f *.patch $TMP_DIR/
  cp -f .env $TMP_DIR
  cp -f $FILE_VIMRC $TMP_DIR

  docker build --network=host -t $IMAGE_NAME $TMP_DIR
}

RUN_CONTAINER()
{
  docker run -it --rm --env-file .env -v $TMP_DIR:/home/sigrok-mxe/workspace $IMAGE_NAME
}

CREATE_CONTAINER_DAEMON()
{
  docker run -d -it --env-file .env --name $container_name -w /home/sigrok-mxe/workspace -v $TMP_DIR:/home/sigrok-mxe/workspace $IMAGE_NAME
}

RUN_CONTAINER_DAEMON()
{
  docker exec -it -u sigrok-mxe $container_name /bin/bash
}

#GEN_HOST_INFO
#GEN_VIMRC
#GEN_ENTRYPOINT
#GEN_DOCKERFILES
#BUILD_CONTAINER
RUN_CONTAINER

