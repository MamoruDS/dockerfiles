#!/bin/sh

error() {
    echo "Error: $1" >&2
    exit 1
}

if ! [ -x "$(command -v curl)" ]; then
    error "curl is not installed"
fi

if ! [ -x "$(command -v git)" ]; then
    error "git is not installed"
fi

_CMD="( \
    cd ~ \
    && export DOTFILES_PACKAGES=$DOTFILES_PACKAGES \
    && export DOTTER_BIN_DIR=$DOTTER_BIN_DIR \
    && export DOTFILES_ROOT=$DOTFILES_ROOT \
    && export DOTFILES_LOCAL=${DOTFILES_LOCAL:-~/.dot.local.toml} \
    && curl -fsSL https://raw.githubusercontent.com/MamoruDS/dotfiles/main/install.sh | sh \
    && echo '[ -f ~/.zshrc.dot ] && . ~/.zshrc.dot' >> ~/.zshrc \
    && if [ -n \$DOTTER_BIN_DIR ] && echo 'DOTTER_BIN_DIR=\$DOTTER_BIN_DIR' >> ~/.zshrc \
    && if [ -n \$DOTFILES_ROOT ] && echo 'DOTFILES_ROOT=\$DOTFILES_ROOT' >> ~/.zshrc \
    && if [ -n \$DOTFILES_LOCAL ] && echo 'DOTTER_BIN_DIR=\$DOTFILES_LOCAL' >> ~/.zshrc
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

