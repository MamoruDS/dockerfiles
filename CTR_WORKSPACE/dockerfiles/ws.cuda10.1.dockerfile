FROM nvidia/cuda:10.1-devel-ubuntu16.04
LABEL maintainer="MamoruDS <mamoruds.io@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \
    tzdata \
    git \
    sudo \
    zsh \
    openssh-server \
    curl \
    dnsutils \
    iputils-ping \
    tmux \ 
    nano

ADD init/ /

EXPOSE 22
CMD service ssh start && sh init.sh && tail -f /dev/null
