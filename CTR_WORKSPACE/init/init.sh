#!/bin/sh

info() {
    printf '%s\n' " > $*"
}

error() {
    printf '%s\n' " > $*" >&2
}

info "- container initialization start -"

info "RESET: SSH Host Keys"
rm -f /etc/ssh/ssh_host_*
ssh-keygen -A

# channel can be branch or tag
REPO_URL='https://raw.githubusercontent.com/MamoruDS/dockerfiles'
SCRIPT_CHANNEL=${SCRIPT_CHANNEL:-main}

TZ=${TZ:-Etc/UTC}
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

_SHELL=${CTR_SHELL:-bash}

_UID=${CTR_UID:-2000}
_USER=${CTR_USER:-ctr}
_GID=${CTR_GID:-}
_GROUP=${CTR_GROUP:-}
PASSWORD=${PASSWORD:-}

if [ ! -z $_GID ]; then
    if [ -z $_GROUP ]; then
        groupadd -g $_GID $_USER
    else
        groupadd -g $_GID $_GROUP
    fi
    useradd -ms /bin/$_SHELL -u $_UID -g $_GID $_USER
    info "ADD: user $_USER:$_GID"
else
    useradd -ms /bin/$_SHELL -u $_UID $_USER
    info "ADD: user $_USER"
fi

if [ $_USER = 'root' ]; then
    HOME="/root"
else
    HOME="/home/$_USER"
fi

if [ -z $PASSWORD ]; then
    info "Generating user password"
    if [ -x "$(command -v openssl)" ]; then
        PASSWORD="$(openssl rand -base64 16)"
    else
        PASSWORD="$(tr -dc '0-9a-zA-Z+//' < /dev/urandom | head -c 16)"
    fi
fi

info "Setting user initial password to $PASSWORD"
usermod -aG sudo $_USER \
    && echo $_USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$_USER \
    && echo 'Set disable_coredump false' >> /etc/sudo.conf \
    && echo $_USER:$PASSWORD|chpasswd
unset PASSWORD 

info "INSTALL: starship"
curl -sf https://starship.rs/install.sh | sh -s -- -y > /dev/null 2>&1

info "INSTALL: fzf"
curl -sfL https://raw.githubusercontent.com/junegunn/fzf/master/install | bash -s -- --bin

info "DEPLOY: dotfiles"
if [ ! -z $CONDA ]; then
    export DOTFILES_PACKAGES="$DOTFILES_PACKAGES,conda"
fi
if [ ! -z $NVIM ]; then
    export DOTFILES_PACKAGES="$DOTFILES_PACKAGES,nvim"
fi
curl -sfL $REPO_URL/$SCRIPT_CHANNEL/scripts/deploy_dotfiles.sh | sh -s -- $_USER

if [ ! -z $CONDA ]; then
    if [ -z $CONDA_HOME ]; then
        CONDA_HOME="$HOME/miniconda"
    fi
    info "INSTALL: conda in $CONDA_HOME"
    curl -sfL $REPO_URL/$SCRIPT_CHANNEL/scripts/install_conda.sh | sh -s -- $_USER $_SHELL $CONDA_HOME
fi

if [ ! -z $NVIM ]; then
    if ! [ -x "$(command -v nvim)" ]; then
        info "INSTALL: neovim"
        curl -sfL $REPO_URL/$SCRIPT_CHANNEL/scripts/install_neovim.sh | sh
    fi
fi

info "EXECUTE: start script"
if [ ! -z $START_SCRIPT ]; then
    sudo -u $_USER sh -c "(cd ~ && curl -sSfL $START_SCRIPT | sh)"
fi

info "- container initialization end -"

rm /*.init /*.sh 2> /dev/null
cat << EOF > /init.sh
#!/bin/sh
if [ ! -f '/.init' ]; then
    cd $HOME && su $_USER || su $_USER
    exit 0
fi
EOF
cd $HOME && su $_USER
