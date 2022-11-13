ARG BASE_UBUNTU=20.04
ARG CUDA_VER=11.3.1
FROM nvidia/cuda:${CUDA_VER}-cudnn8-devel-ubuntu${BASE_UBUNTU}
LABEL maintainer="MamoruDS <mamoruds.io@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \
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
    nano \
    libevent-dev \
    libncurses-dev
RUN locale-gen en_US.UTF-8

ADD init/ /

EXPOSE 22
CMD service ssh start && \
    sh init.sh 2>&1 | tee /dev/null ; \
    tail -f /dev/null
