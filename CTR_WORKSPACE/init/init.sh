# !/bin/sh

if [ ! -f '/.init' ]; then
    cd /home/$USER && su $USER || su $USER
    exit 0
fi

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
if [ -z $GID ]; then
    GID='1000'
fi
if [ -z $USER ]; then
    USER='ctr'
fi
if [ -z $PASSWORD ]; then
    PASSWORD='localpasswd'
fi
useradd -ms /bin/$SHELL --uid=$UID --gid=$GID $USER \
    && usermod -aG sudo $USER \
    && echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER \
    && echo 'Set disable_coredump false' >> /etc/sudo.conf \
    && echo ${USER}:${PASSWORD}|chpasswd
unset PASSWORD

if [ ! -z $GIT_EMAIL ]; then
    su -s /bin/bash -c "git config --global user.email $GIT_EMAIL" - $USER
    su -s /bin/bash -c "git config --global user.name $GIT_NAME" - $USER
fi

if [ "$SHELL" = 'zsh' ]; then
    mkdir -p /home/$USER \
        && chown $USER /zsh_shell.sh && chmod u+x /zsh_shell.sh \
        && su -s /bin/bash -c "/zsh_shell.sh $USER" - $USER
fi

if [ ! -z $CONDA ]; then
    chown $USER /conda.sh && chmod u+x /conda.sh \
        && su -s /bin/bash -c "/conda.sh $USER $SHELL" - $USER
fi

rm /.init /zsh_shell.sh \
    && cd /home/$USER \
    && su $USER
