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

if [ ! -z $GIT_EMAIL ]; then
    su -s /bin/bash -c "git config --global user.email $GIT_EMAIL" - $USER
    su -s /bin/bash -c "git config --global user.name $GIT_NAME" - $USER
fi

if [ "$SHELL" = 'zsh' ]; then
    mkdir -p $HOME \
        && chown $USER /zsh_shell.sh && chmod u+x /zsh_shell.sh \
        && su -s /bin/bash -c "/zsh_shell.sh $USER" - $USER
fi

if [ ! -z $CONDA ]; then
    chown $USER /conda.sh && chmod u+x /conda.sh \
        && su -s /bin/bash -c "/conda.sh $USER $SHELL" - $USER
fi

if [ ! -z $CUSTOM_NVIM ]; then
    if ! [ -x "$(command -v node)" ]; then
        curl -sL https://install-node.now.sh/lts | bash -s -- --yes
    fi
    if ! [ -x "$(command -v nvim)" ]; then
        curl -sL https://raw.githubusercontent.com/MamoruDS/vimrc/main/install_neovim.sh | sh
    fi
    chown $USER /custom_nvim.sh && chmod u+x /custom_nvim.sh \
        && sudo su -s /bin/bash -c "/custom_nvim.sh $USER" - $USER
fi

if [ -f "/usr/bin/vncserver" ]; then
    VNC=$HOME/.vnc
    mkdir -p $VNC \
        && mv vncpasswd $VNC/passwd \
        && mv xstartup $VNC/xstartup
    chown -R $USER $VNC \
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
