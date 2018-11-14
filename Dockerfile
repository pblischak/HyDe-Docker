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

# Install miniconda
WORKDIR /home
RUN wget https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh \
  && bash Miniconda2-latest-Linux-x86_64.sh -b -p /home/miniconda2
ENV PATH /home/miniconda2/bin:$PATH

# Install necessary python package
WORKDIR /home
RUN conda install cython numpy matplotlib seaborn \
  && pip2 install -q multiprocess

WORKDIR /home
RUN git clone https://github.com/pblischak/HyDe.git \
  && cd HyDe \
  && pip2 install -U . \
  && make test

WORKDIR /home
CMD bash