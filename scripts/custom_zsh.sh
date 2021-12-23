# !/bin/sh

if ! [ -x "$(command -v curl)" ]; then
    echo "curl is not installed"
    exit 1
fi

if ! [ -x "$(command -v git)" ]; then
    echo "git is not installed"
    exit 1
fi

if ! [ -x "$(command -v zsh)" ]; then
    echo "zsh is not installed"
    exit 1
fi

USERNAME=$1
if [ -z $USERNAME ]; then
    USERNAME=$(whoami)
fi

if [ -z $HOME ]; then
    HOME="/home/$USERNAME"
    if [ $USERNAME = 'root' ]; then
        HOME="/root"
    fi
fi

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

touch $HOME/.zshrc \
    && chown $USERNAME $HOME/.zshrc \
    # && su $USERNAME

curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o $HOME/oh_my_zsh.sh \
    && zsh $HOME/oh_my_zsh.sh --unattended \
    && rm $HOME/oh_my_zsh.sh
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" \
    && ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

curl https://raw.githubusercontent.com/MamoruDS/dockerfiles/master/CTR_WORKSPACE/.zshrc -o $HOME/.zshrc \
    && curl https://raw.githubusercontent.com/MamoruDS/dockerfiles/master/CTR_WORKSPACE/.tmux.conf -o $HOME/.tmux.conf \
    && curl https://raw.githubusercontent.com/MamoruDS/dockerfiles/master/CTR_WORKSPACE/.config/zsh_theme_highlight.sh -o $HOME/.config/zsh_theme_highlight.sh --create-dirs \
    && curl https://raw.githubusercontent.com/MamoruDS/dockerfiles/master/CTR_WORKSPACE/.config/zsh_theme_spaceship.sh -o $HOME/.config/zsh_theme_spaceship.sh --create-dirs \
    && curl https://raw.githubusercontent.com/MamoruDS/dockerfiles/master/CTR_WORKSPACE/scripts/utils.sh -o $HOME/scripts/utils.sh --create-dirs

chown $USERNAME $HOME/.zshrc
chown $USERNAME $HOME/.tmux.conf
chown -R $USERNAME $HOME/.oh-my-zsh
chown $USERNAME $HOME/.config/zsh_theme_highlight.sh 
chown $USERNAME $HOME/.config/zsh_theme_spaceship.sh 
