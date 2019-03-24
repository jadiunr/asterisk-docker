FROM centos:7.6.1810

# Install dependencies.
RUN yum -y update && \
    yum -y groupinstall "Development Libraries" "Additional Development" && \
    yum -y install \
      gcc \
      gcc-c++ \
      libxml2 \
      libxml2-devel \
      openssl-devel \
      ncurses-devel \
      sqlite-devel \
      newt-devel \
      libuuid-devel \
      uuid-devel \
      json-c \
      json-c-devel \
      subversion \
      bzip2 \
      patch \
      libedit-devel \
      wget && \
    yum clean all

# Install Jansson
WORKDIR /tmp
RUN wget http://www.digip.org/jansson/releases/jansson-2.12.tar.gz && \
    tar zxvf jansson-2.12.tar.gz && \
    cd jansson-2.12 && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf jansson-2.12 jansson-2.12.tar.gz

# Configure ld.so.conf
RUN echo "/usr/local/lib" >> /etc/ld.so.conf

# Install Asterisk
RUN wget https://www.pjsip.org/release/2.8/pjproject-2.8.tar.bz2 && \
    wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16.2.1.tar.gz && \
    tar zxvf asterisk-16.2.1.tar.gz && \
    cd asterisk-16.2.1 && \
    ./configure && \
    make && \
    make install && \
    make config && \
    cd .. && \
    rm -rf pjproject-2.8.tar.bz2 asterisk-16.2.1 asterisk-16.2.1.tar.gz
