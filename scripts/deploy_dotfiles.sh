#!/bin/sh

info() {
    printf '%s\n' "Info: $*"
}

panic() {
    printf '%s\n' "Error: $*" >&2
    exit 1
}

if ! [ -x "$(command -v curl)" ]; then
    panic "curl is not installed"
fi

if ! [ -x "$(command -v git)" ]; then
    panic "git is not installed"
fi

_DEPLOY_SCRIPT_URL=${DOTFILES_DEPLOY_SCRIPT_URL:-'https://raw.githubusercontent.com/MamoruDS/dotfiles/main/install.sh'}
_CMD="( \
    cd ~ \
    && export DOTFILES_PACKAGES=$DOTFILES_PACKAGES \
    && export DOTTER_BIN_DIR=$DOTTER_BIN_DIR \
    && export DOTFILES_ROOT=$DOTFILES_ROOT \
    && export DOTFILES_LOCAL=${DOTFILES_LOCAL:-'$HOME/.dot.local.toml'} \
    && curl -fsSL ${_DEPLOY_SCRIPT_URL} | sh
)"

target_user="$1"
if [ -z $target_user ]; then
    eval $_CMD
else
    if [ -x "$(command -v sudo)" ]; then
        sudo su $target_user -c "$_CMD"
    else
        su $target_user -c "$_CMD"
    fi
fi

