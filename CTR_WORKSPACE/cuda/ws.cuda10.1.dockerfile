ARG CUDA_VER=10.2
FROM nvidia/cuda:${CUDA_VER}-devel-ubuntu18.04
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
    nano
RUN locale-gen en_US.UTF-8

ADD init/ /

EXPOSE 22
CMD service ssh start && \
    sh init.sh 2> /dev/null ; \
    tail -f /dev/null
