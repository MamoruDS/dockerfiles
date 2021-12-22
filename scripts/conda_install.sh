# !/bin/sh

USERNAME=$1
if [ -z $USERNAME ]; then
    USERNAME=$(whoami)
fi
SHELL=$2

if [ -z $HOME ]; then
    HOME="/home/$USERNAME"
    if [ $USERNAME = 'root' ]; then
        HOME="/root"
    fi
fi

if [ "$SHELL" == "bash" ]; then
    changeps1=True
else
    changeps1=False
fi

curl -fSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-$(uname -m).sh -o miniconda.sh \
    && sh miniconda.sh -b -p $HOME/miniconda \
    && $HOME/miniconda/bin/conda init $SHELL \
    && $HOME/miniconda/bin/conda config --set auto_activate_base false \
    && $HOME/miniconda/bin/conda config --set changeps1 $changeps1 \
    && rm miniconda.sh
