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

# installation of node lts
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt install -y nodejs
ADD init/ /

EXPOSE 22
CMD service ssh start && sh init.sh
