ARG CUDA_VER=11.4
FROM nvidia/cuda:${CUDA_VER}-devel-ubuntu20.04
LABEL maintainer="MamoruDS <mamoruds.io@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \
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

ADD init/ /

RUN apt install -y --no-install-recommends \
    xfce4 \
    xfce4-goodies \
    xfonts-base \
    xubuntu-icon-theme \
    dbus-x11 \
    tightvncserver

EXPOSE 22 5901
CMD service ssh start && \
    sh init.sh 2> /dev/null ; \
    tail -f /dev/null

