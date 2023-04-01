#!/bin/sh

panic() {
    printf '%s\n' "! Error: $*" >&2
    exit 1
}

if ! [ $(uname -s) = 'Linux' ]; then
    panic 'This script only supports Linux'
fi

if ! [ $(uname -m) = 'x86_64' ]; then
    panic 'This script only supports x86_64'
fi

if ! [ -x "$(command -v curl)" ]; then
    panic 'curl is not installed'
fi

curl -sfLO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz \
    && tar -zxf nvim-linux64.tar.gz \
    && rm -rf nvim-linux64/share/man \
    && cp -r nvim-linux64/* /usr/local/

rm -rf nvim-linux64.tar.gz nvim-linux64 &> /dev/null

