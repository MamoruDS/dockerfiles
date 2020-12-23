# !/bin/sh

USERNAME=$1
if [ -z $USERNAME ]; then
    USERNAME=$(whoami)
fi
SHELL=$2

HOME=/home/$USERNAME

# x86_64 only
curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh \
    && sh miniconda.sh -b -p $HOME/miniconda \
    && $HOME/miniconda/bin/conda init $SHELL \
    && $HOME/miniconda/bin/conda config --set auto_activate_base false \
    && $HOME/miniconda/bin/conda config --set changeps1 False \
    && rm miniconda.sh
