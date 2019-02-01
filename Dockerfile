FROM debian:stable

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
        --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        genisoimage \
        git \
        libseccomp-dev \
        libxen-dev \
        sudo \
        xorriso \
        zlib1g-dev \
    && apt-get clean

RUN DESTDIR=/usr/local && \
    git clone https://github.com/cloudkernels/rumprun -b solo5-tests-aarch64 && \
    cd rumprun && \
    git submodule init && git submodule update && \
    DESTDIR=$DESTDIR make && \
    cd ../ && rm -rf rumprun

