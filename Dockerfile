FROM ubuntu:18.04

# Set up working locales and upgrade the base image
ENV LANG="C.UTF-8"

ARG UBUNTU_MIRROR

RUN { [ ! "$UBUNTU_MIRROR" ] || sed -i "s|http://\(\w*\.\)*archive\.ubuntu\.com/ubuntu/\? |$UBUNTU_MIRROR |" /etc/apt/sources.list; } && \
    apt-get -q update && \
    apt-get -q dist-upgrade -y 
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -q install --no-install-recommends -y patch patchutils && \ 
    apt-get -q install --no-install-recommends -y libc6-dev libxml-dom-perl && \
    apt-get -q install --no-install-recommends -y zlib1g zlib1g-dev && \
    apt-get -q install --no-install-recommends -y libcurl4-openssl-dev

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -q install --no-install-recommends -y python-pip

RUN pip install sentry_sdk 

RUN pip install setuptools
RUN pip install gitpython

RUN pip install --index-url https://pypi.tuna.tsinghua.edu.cn/simple/  numpy

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -q install --no-install-recommends -y libssl1.0-dev nodejs-dev node-gyp nodejs npm 

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -q install --no-install-recommends -y libpcre3-dev 

RUN npm install beautifier

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -q install --no-install-recommends -y git 

COPY ./jdk-8u291-linux-x64.tar.gz /usr/share/jdk/

RUN cd /usr/share/jdk && \
    tar -zxvf jdk-8u291-linux-x64.tar.gz && \
	mkdir -p /usr/lib/jvm/ && \
	mv jdk1.8.0_291 /usr/lib/jvm/ && \
	update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_291/bin/javac 1 && \
	update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_291/bin/java 1 && \
	update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/jdk1.8.0_291/bin/javaws 1 && \
	update-alternatives --config javac && \
	update-alternatives --config java && \
	update-alternatives --config javaws

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -q install --no-install-recommends -y build-essential 
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -q install --no-install-recommends -y flex 
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -q install --no-install-recommends -y bison 
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -q install --no-install-recommends -y bc 
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -q install --no-install-recommends -y rsync 
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -q install --no-install-recommends -y netpbm 

RUN DEBIAN_FRONTEND=noninteractive\
	dpkg --add-architecture i386 && \
	apt-get -q update

RUN DEBIAN_FRONTEND=noninteractive\
	apt-get -q install --no-install-recommends -y libc6:i386
RUN DEBIAN_FRONTEND=noninteractive\
	apt-get -q install --no-install-recommends -y libncurses5:i386
RUN DEBIAN_FRONTEND=noninteractive\
	apt-get -q install --no-install-recommends -y libstdc++6:i386
RUN DEBIAN_FRONTEND=noninteractive\
	apt-get -q install --no-install-recommends -y lib32z1

RUN DEBIAN_FRONTEND=noninteractive\
	apt-get -q install --no-install-recommends -y zlib1g-dev:i386

RUN DEBIAN_FRONTEND=noninteractive\
	apt-get -q install --no-install-recommends -y grunt

RUN echo "deb https://mirrors.ustc.edu.cn/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list
 
RUN DEBIAN_FRONTEND=noninteractive\
	apt-get -q install --no-install-recommends -y tzdata
RUN DEBIAN_FRONTEND=noninteractive\
	apt-get update && \
	apt-get -q install --no-install-recommends -y php5-cli

RUN DEBIAN_FRONTEND=noninteractive\
	apt-get -q install --no-install-recommends -y autoconf automake libtool m4

RUN DEBIAN_FRONTEND=noninteractive\
	apt-get -q install --no-install-recommends -y libcanberra-gtk-module
RUN DEBIAN_FRONTEND=noninteractive\
	apt-get -q install --no-install-recommends -y libgtk2.0-dev

RUN DEBIAN_FRONTEND=noninteractive\
	apt-get -q install --no-install-recommends -y vim

RUN DEBIAN_FRONTEND=noninteractive\
	apt-get -q install --no-install-recommends -y squashfs-tools
# make /bin/sh symlink to bash instead of dash:
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

