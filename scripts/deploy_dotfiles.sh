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

_CMD="( \
    cd ~ \
    && export DOTFILES_PACKAGES=$DOTFILES_PACKAGES \
    && export DOTTER_BIN_DIR=$DOTTER_BIN_DIR \
    && export DOTFILES_ROOT=$DOTFILES_ROOT \
    && export DOTFILES_LOCAL=${DOTFILES_LOCAL:-~/.dot.local.toml} \
    && curl -fsSL https://raw.githubusercontent.com/MamoruDS/dotfiles/main/install.sh | sh \
    && echo '[ -f ~/.zshrc.dot ] && . ~/.zshrc.dot' >> ~/.zshrc \
    && if [ -n \"\$DOTTER_BIN_DIR\" ]; then echo \"DOTTER_BIN_DIR=\$DOTTER_BIN_DIR\" >> ~/.zshrc ; fi \
    && if [ -n \"\$DOTFILES_ROOT\" ]; then echo \"DOTFILES_ROOT=\$DOTFILES_ROOT\" >> ~/.zshrc ; fi \
    && if [ -n \"\$DOTFILES_LOCAL\" ]; then echo \"DOTFILES_LOCAL=\$DOTFILES_LOCAL\" >> ~/.zshrc ; fi
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

