export CONFIG=${HOME}/.config
export SCRIPT=${HOME}/scripts

export USER=${USERNAME}
export WORKSPACE=/WORKSPACE
export ZSH=${HOME}/.oh-my-zsh

export PATH=${HOME}/bin:/usr/local/bin:$PATH

TERM=xterm-256color

ZSH_THEME="spaceship"

source $CONFIG/zsh_theme_spaceship.sh
source $CONFIG/zsh_theme_highlight.sh
source $SCRIPT/ws_shell_utils.sh

plugins=(
    git
    pip
    npm
    npx
    nvm
    node
    python
    docker
    docker-compose
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
unset zle_bracketed_paste
