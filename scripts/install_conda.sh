#!/bin/sh

error() {
    echo "Error: $1" >&2
    exit 1
}

if ! [ -x "$(command -v bash)" ]; then
    error "bash is not installed"
fi

if ! [ -x "$(command -v curl)" ]; then
    error "curl is not installed"
fi

target_user="$1"
user_shell=${2:-bash}
conda_home=${3:-'~/miniconda'}

_install_cmd="( \
    if [ ! -f $conda_home/bin/conda ]; then \
        curl -fSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-$(uname -m).sh -o ~/miniconda.sh \
        && bash ~/miniconda.sh -b -p $conda_home \
        && rm ~/miniconda.sh \
    ; fi \
)"

_init_cmd="if [ -f "$conda_home"/bin/conda ]; then $conda_home/bin/conda init $user_shell; fi"


if [ -z $target_user ]; then
    eval $_install_cmd
    eval $_init_cmd
else
    if [ -x "$(command -v sudo)" ]; then
        sudo su $target_user -c "$_install_cmd"
        sudo su $target_user -c "$_init_cmd"
    else
        su $target_user -c "$_install_cmd"
        su $target_user -c "$_init_cmd"
    fi
fi

