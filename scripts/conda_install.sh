# !/bin/sh

USERNAME=$1
if [ -z $USERNAME ]; then
    USERNAME=$(whoami)
fi
SHELL=$2
CONDA_HOME=$3

if [ -z $HOME ]; then
    HOME="/home/$USERNAME"
    if [ $USERNAME = 'root' ]; then
        HOME="/root"
    fi
fi

if [ "$SHELL" = "bash" ]; then
    changeps1=True
else
    changeps1=False
fi

if [ -z $CONDA_HOME ]; then
    CONDA_HOME="$HOME/miniconda"
fi

if [ -d $CONDA_HOME ]; then
    $CONDA_HOME/bin/conda init $SHELL \
        && $CONDA_HOME/bin/conda config --set auto_activate_base false \
        && $CONDA_HOME/bin/conda config --set changeps1 $changeps1

else
    curl -fSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-$(uname -m).sh -o $HOME/miniconda.sh \
        && sh $HOME/miniconda.sh -b -p $CONDA_HOME \
        && $CONDA_HOME/bin/conda init $SHELL \
        && $CONDA_HOME/bin/conda config --set auto_activate_base false \
        && $CONDA_HOME/bin/conda config --set changeps1 $changeps1 \
        && rm $HOME/miniconda.sh
fi


