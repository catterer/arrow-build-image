FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update  \
        && apt-get install -y build-essential git cmake autoconf libtool pkg-config  \
        && apt install -y -V ca-certificates lsb-release wget  \
        && wget https://apache.jfrog.io/artifactory/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb  \
        && apt install -y -V ./apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb  \
        && apt update  \
        && apt install -y -V libarrow-dev libarrow-dataset-dev libarrow-flight-dev libparquet-dev
RUN apt-get install -y git g++ make binutils autoconf automake autotools-dev libtool pkg-config zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev libc-ares-dev libjemalloc-dev libsystemd-dev cython python3-dev python3-setuptools libboost-system-dev libasio-dev

RUN git clone https://github.com/nghttp2/nghttp2.git && \
cd nghttp2 && \
git submodule update --init && \
autoreconf -i && \
automake && \
autoconf && \
./configure --enable-asio-lib && \
make && \
make install && \
cd ..
ENV LD_LIBRARY_PATH=/usr/local/lib/
RUN apt install -y gdb
