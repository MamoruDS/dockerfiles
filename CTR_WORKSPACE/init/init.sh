# !/bin/sh

info() {
    printf '%s\n' " > $*"
}

error() {
    printf '%s\n' " > $*" >&2
}

info "- container initialization start -"

if [ -z $SHELL ]; then
    SHELL='bash'
fi

if [ -z $TZ ]; then
    TZ='Etc/UTC'
fi
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

if [ -z $UID ]; then
    UID='1000'
fi
if [ -z $USER ]; then
    USER='ctr'
fi
if [ ! -z $GID ]; then
    if [ -z $GROUP ]; then
        groupadd -g $GID $USER
    else
        groupadd -g $GID $GROUP
    fi
    useradd -ms /bin/$SHELL -u $UID -g $GID $USER
    info "ADD: user $USER:$GID"
else
    useradd -ms /bin/$SHELL -u $UID $USER
    info "ADD: user $USER"
fi
if [ -z $PASSWORD ]; then
    PASSWORD='localpasswd'
fi
if [ $USER = 'root' ]; then
    HOME="/root"
else
    HOME="/home/$USER"
fi


usermod -aG sudo $USER \
    && echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER \
    && echo 'Set disable_coredump false' >> /etc/sudo.conf \
    && echo ${USER}:${PASSWORD}|chpasswd
cat /dev/null > $HOME/.hushlogin && chown $USER $HOME/.hushlogin
unset PASSWORD 

if [ ! -z $START_SCRIPT ]; then
    info "FETCH: script from $START_SCRIPT"
    curl -sSfL $START_SCRIPT -o /start_script.sh
fi
if [ -f "/start_script.sh" ]; then
    info "EXECUTE: start script"
    chown $USER /start_script.sh \
        && chmod u+x /start_script.sh \
        && sudo -H -u $USER bash -c "/start_script.sh"
fi

if [ ! -z $CONDA ]; then
    if [ -z $CONDA_HOME ]; then
        CONDA_HOME="$HOME/miniconda"
    fi
    info "INSTALL: conda in $CONDA_HOME"
    curl -sL https://raw.githubusercontent.com/MamoruDS/dockerfiles/main/scripts/conda_install.sh -o /conda_install.sh \
        && chown $USER /conda_install.sh \
        && chmod u+x /conda_install.sh \
        && sudo -H -u $USER bash -c "/conda_install.sh $USER $SHELL $CONDA_HOME"
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
        && curl -sL https://raw.githubusercontent.com/MamoruDS/dockerfiles/main/CTR_WORKSPACE/init/vncpasswd.init -o $VNC/passwd \
        && curl -sL https://raw.githubusercontent.com/MamoruDS/dockerfiles/main/CTR_WORKSPACE/init/xstartup.init -o $VNC/xstartup \
        && chown -R $USER $VNC \
        && chmod 755 $VNC/xstartup
    sudo -u $USER vncserver
fi

info "- container initialization end -"

rm /*.init /*.sh 2> /dev/null
cat << EOF > /init.sh
#!/bin/sh
if [ ! -f '/.init' ]; then
    cd $HOME && su $USER || su $USER
    exit 0
fi
EOF
cd $HOME && su $USER
