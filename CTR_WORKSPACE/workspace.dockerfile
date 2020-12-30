FROM ubuntu:20.04
LABEL maintainer="MamoruDS <mamoruds.io@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \
    git \
    sudo \
    zsh \
    openssh-server \
    curl \
    dnsutils \
    iputils-ping \
    tmux \
    # changing to vim/nano ...etc
    neovim

ADD init/ /

EXPOSE 22
CMD service ssh start && sh init.sh && tail -f /dev/null
