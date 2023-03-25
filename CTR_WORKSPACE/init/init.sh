# !/bin/sh

info() {
    printf '%s\n' " > $*"
}

error() {
    printf '%s\n' " > $*" >&2
}

info "- container initialization start -"

# channel can be branch or tag
SCRIPT_CHANNEL=${SCRIPT_CHANNEL:-main}

TZ=${TZ:-Etc/UTC}
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

_SHELL=${CTR_SHELL:-bash}

_UID=${CTR_UID:-1000}
_USER=${CTR_USER:-ctr}
_GID=${CTR_GID:-}
_GROUP=${CTR_GROUP:-}
PASSWORD=${PASSWORD:-localpasswd}

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

usermod -aG sudo $_USER \
    && echo $_USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$_USER \
    && echo 'Set disable_coredump false' >> /etc/sudo.conf \
    && echo $_USER:$PASSWORD|chpasswd
unset PASSWORD 

if [ ! -z $START_SCRIPT ]; then
    info "FETCH: script from $START_SCRIPT"
    curl -sSfL $START_SCRIPT -o /start_script.sh
fi
if [ -f "/start_script.sh" ]; then
    info "EXECUTE: start script"
    chown $_USER /start_script.sh \
        && chmod u+x /start_script.sh \
        && sudo -H -u $_USER bash -c "/start_script.sh"
fi

info "INSTALL: starship"
curl -sf https://starship.rs/install.sh | sh -s -- -y > /dev/null 2>&1

info "DEPLOY: dotfiles"
if [ ! -z $CONDA ]; then
    export DOTFILES_PACKAGES="$DOTFILES_PACKAGES,conda"
fi
curl -sfL https://raw.githubusercontent.com/MamoruDS/dockerfiles/main/scripts/deploy_dotfiles.sh | sh -s -- $_USER

if [ ! -z $CONDA ]; then
    if [ -z $CONDA_HOME ]; then
        CONDA_HOME="$HOME/miniconda"
    fi
    info "INSTALL: conda in $CONDA_HOME"
    curl -sL https://raw.githubusercontent.com/MamoruDS/dockerfiles/$SCRIPT_CHANNEL/scripts/install_conda.sh -o /conda_install.sh \
        && chown $_USER /conda_install.sh \
        && chmod u+x /conda_install.sh \
        && sudo -H -u $_USER bash -c "/conda_install.sh $_USER $_SHELL $CONDA_HOME"
fi

if [ ! -z $CUSTOM_NVIM ]; then
    if ! [ -x "$(command -v nvim)" ]; then
        info "INSTALL: neovim"
        curl -sL https://raw.githubusercontent.com/MamoruDS/vimrc/main/install_neovim.sh | sh
    fi
fi

if [ -f "/usr/bin/vncserver" ]; then
    info "START: VNC server"
    VNC=$HOME/.vnc
    mkdir -p $VNC \
        && curl -sL https://raw.githubusercontent.com/MamoruDS/dockerfiles/$SCRIPT_CHANNEL/CTR_WORKSPACE/init/vncpasswd.init -o $VNC/passwd \
        && curl -sL https://raw.githubusercontent.com/MamoruDS/dockerfiles/$SCRIPT_CHANNEL/CTR_WORKSPACE/init/xstartup.init -o $VNC/xstartup \
        && chown -R $_USER $VNC \
        && chmod 755 $VNC/xstartup
    sudo -u $_USER vncserver
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
