# !/bin/sh

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
else
    useradd -ms /bin/$SHELL -u $UID $USER
fi
if [ -z $PASSWORD ]; then
    PASSWORD='localpasswd'
fi
if [ -z $HOME ]; then
    HOME="/home/$USER"
    if [ $USER = 'root' ]; then
        HOME="/root"
    fi
fi

usermod -aG sudo $USER \
    && echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER \
    && echo 'Set disable_coredump false' >> /etc/sudo.conf \
    && echo ${USER}:${PASSWORD}|chpasswd
unset PASSWORD

if [ ! -z $START_SCRIPT ]; then
    curl -sSfL $START_SCRIPT -o /start_script.sh
fi
if [ -f "/start_script.sh" ]; then
    chown $USER /start_script.sh \
        && chmod u+x /start_script.sh \
        && sudo -H -u $USER bash -c "/start_script.sh"
fi

if [ "$SHELL" = 'zsh' ]; then
    curl -sL https://raw.githubusercontent.com/MamoruDS/dockerfiles/main/scripts/custom_zsh.sh -o /zsh_shell.sh \
        && chown $USER /zsh_shell.sh \
        && chmod u+x /zsh_shell.sh \
        && sudo -H -u $USER bash -c "/zsh_shell.sh $USER"
fi

if [ ! -z $CONDA ]; then
    if [ -z $CONDA_HOME ]; then
        CONDA_HOME="$HOME/miniconda"
    fi
    curl -sL https://raw.githubusercontent.com/MamoruDS/dockerfiles/main/scripts/conda_install.sh -o /conda_install.sh \
        && chown $USER /conda_install.sh \
        && chmod u+x /conda_install.sh \
        && sudo -H -u $USER bash -c "/conda_install.sh $USER $SHELL $CONDA_HOME"
fi

if [ ! -z $CUSTOM_NVIM ]; then
    if ! [ -x "$(command -v node)" ]; then
        curl -sL https://install-node.now.sh/lts | bash -s -- --yes
    fi
    if ! [ -x "$(command -v nvim)" ]; then
        curl -sL https://raw.githubusercontent.com/MamoruDS/vimrc/main/install_neovim.sh | sh
    fi
    curl -sL https://raw.githubusercontent.com/MamoruDS/dockerfiles/main/scripts/custom_nvim.sh -o /custom_nvim.sh \
        && chown $USER /custom_nvim.sh \
        && chmod u+x /custom_nvim.sh \
        && sudo -H -u $USER bash -c "/custom_nvim.sh $USER"
fi

if [ -f "/usr/bin/vncserver" ]; then
    VNC=$HOME/.vnc
    mkdir -p $VNC \
        && curl -sL https://raw.githubusercontent.com/MamoruDS/dockerfiles/main/CTR_WORKSPACE/init/vncpasswd -o $VNC/passwd \
        && curl -sL https://raw.githubusercontent.com/MamoruDS/dockerfiles/main/CTR_WORKSPACE/init/xstartup -o $VNC/xstartup \
        && chown -R $USER $VNC \
        && chmod 755 $VNC/xstartup
    sudo -u $USER vncserver
fi

rm /.init /*.sh 2> /dev/null
cat << EOF > /init.sh
#!/bin/sh
if [ ! -f '/.init' ]; then
    cd $HOME && su $USER || su $USER
    exit 0
fi
EOF
cd $HOME && su $USER
