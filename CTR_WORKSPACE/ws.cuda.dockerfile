ARG BASE_UBUNTU=22.04
ARG CUDA_VER=11.7.1
ARG CUDNN_VER=cudnn8
FROM nvidia/cuda:${CUDA_VER}-${CUDNN_VER}-devel-ubuntu${BASE_UBUNTU}
LABEL maintainer="MamoruDS <mamoruds.io@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update \
    && apt install -y \
    tzdata \
    locales \
    git \
    gnupg \
    sudo \
    zsh \
    openssh-server \
    curl \
    dnsutils \
    iputils-ping \
    tmux \
    rsync \
    libevent-dev \
    libncurses-dev \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*
RUN locale-gen en_US.UTF-8

ADD init/ /

EXPOSE 22
CMD service ssh start && \
    sh init.sh 2>&1 | tee /dev/null ; \
    tail -f /dev/null
