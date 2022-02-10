FROM ubuntu:20.04
WORKDIR /
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y \
    git \
    autoconf \
    automake \
    pkg-config \
    gcc \
    libevent-dev \
    libncurses-dev \
    make \
    byacc \
    build-essential
RUN git clone https://github.com/tmux/tmux.git && \
    cd tmux && \
    git checkout 3.2a && \
    sh autogen.sh && \
    ./configure && \
    make

FROM ubuntu:20.04
WORKDIR /root/dist
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y \
    libevent-lib \
    libncurses-dev

COPY --from=0 /tmux/tmux ./
