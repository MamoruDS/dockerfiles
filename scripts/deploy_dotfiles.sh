# !/bin/sh

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
    echo '[ -f ~/.zshrc.dot ] && . ~/.zshrc.dot' > ~/.zshrc \
    && cd ~ \
    && export DOTFILES_LOCAL=~/.dot.local.toml \
    && curl -fsSL https://raw.githubusercontent.com/MamoruDS/dotfiles/main/install.sh | sh
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

