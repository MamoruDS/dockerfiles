FROM ubuntu:20.04
LABEL maintainer="MamoruDS <mamoruds.io@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install --no-install-recommends -y \
    locales \
    xvfb \
    fluxbox \
    x11vnc

RUN locale-gen en_US.UTF-8
