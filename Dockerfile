# Dockerfile for HyDe

FROM ubuntu

MAINTAINER Paul Blischak <blischak.4@osu.edu>

# Run update and then install C/C++ compilers and make
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y \
                     gcc \
                     g++ \
                     make \
                     git \
                     wget \
                     build-essential \
                     checkinstall \
                     libreadline-gplv2-dev \
                     libncursesw5-dev \
                     libssl-dev \
                     libsqlite3-dev \
                     libgdbm-dev \
                     libc6-dev \
                     libbz2-dev \
                     tk-dev \
                     python-pip

# Install necessary python package
WORKDIR /tmp
RUN pip install -q -U cython numpy matplotlib seaborn multiprocess

WORKDIR /home
RUN git clone https://github.com/pblischak/HyDe.git \
  && cd HyDe \
  && pip install -U . \
  && make test

WORKDIR /home
CMD bash