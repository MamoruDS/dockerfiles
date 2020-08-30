export PATH=${HOME}/bin:/usr/local/bin:$PATH
export ZSH=${HOME}/.oh-my-zsh
export CONFIG=${HOME}/.config
export WORKSPACE=/WORKSPACE

mkcdir() {
    mkdir -p -- "$1" && cd -P -- "$1"
}
color_test() {
    curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash
}
TERM=xterm-256color
export USER=${USERNAME}
ZSH_THEME="spaceship"

SPACESHIP_PROMPT_ORDER=(
    user        # Username section
    host        # Hostname section
    dir         # Current directory section
    time        # Time stampts section
    git         # Git section (git_branch + git_status)
    hg          # Mercurial section (hg_branch  + hg_status)
    package     # Package version
    ruby        # Ruby section
    elixir      # Elixir section
    xcode       # Xcode section
    swift       # Swift section
    golang      # Go section
    php         # PHP section
    rust        # Rust section
    haskell     # Haskell Stack section
    julia       # Julia section
    aws         # Amazon Web Services section
    venv        # virtualenv section
    conda       # conda virtualenv section
    exec_time   # Execution time
    line_sep    # Line break
    battery     # Battery level and status
    vi_mode     # Vi-mode indicator
    jobs        # Background jobs indicator
    exit_code   # Exit code section
    char        # Prompt character
    # node      # Node.js section
    # docker    # Docker section
    # pyenv     # Pyenv section
)

SPACESHIP_CHAR_SYMBOL=': '
SPACESHIP_CHAR_SYMBOL_ROOT='$ '
SPACESHIP_CHAR_COLOR_SUCCESS='black'
SPACESHIP_CHAR_COLOR_FAILURE='red'
SPACESHIP_CHAR_COLOR_SECONDARY='yellow'
SPACESHIP_USER_SHOW='false'
SPACESHIP_USER_COLOR='cyan'
SPACESHIP_USER_COLOR_SSH='cyan'
if [ -z "$TMUX" ]; then
        SPACESHIP_HOST_SHOW='true'
else
        SPACESHIP_HOST_SHOW='false'
fi
SPACESHIP_HOST_PREFIX='at '
SPACESHIP_HOST_COLOR='green'
SPACESHIP_HOST_COLOR_SSH='white'
SPACESHIP_DIR_SHOW='true'
SPACESHIP_DIR_COLOR='cyan' #"magenta"
SPACESHIP_DIR_TRUNC=2
SPACESHIP_DIR_TRUNC_PREFIX='.../'
SPACESHIP_GIT_BRANCH_SHOW='true'
SPACESHIP_GIT_BRANCH_COLOR='bright-magenta'
SPACESHIP_GIT_BRANCH_COLOR='182'
SPACESHIP_PACKAGE_SHOW='false'
SPACESHIP_PACKAGE_SYMBOL='P-'
SPACESHIP_PACKAGE_PREFIX=''
SPACESHIP_PACKAGE_COLOR='green'
SPACESHIP_DOCKER_PREFIX=' '
SPACESHIP_DOCKER_SYMBOL='D-'
SPACESHIP_DOCKER_VERBOSE='false'
SPACESHIP_TIME_SHOW='true'
SPACESHIP_TIME_PREFIX=''
SPACESHIP_TIME_SUFFIX=' '
SPACESHIP_TIME_FORMAT='%*'
SPACESHIP_TIME_COLOR='black'
SPACESHIP_EXEC_TIME_PREFIX=''

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

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

typeset -A ZSH_HIGHLIGHT_STYLES

# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=white,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=white,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=red'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[assign]='fg=white'
ZSH_HIGHLIGHT_STYLES[comment]='fg=black,bold'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=blue,bold'

source $ZSH/oh-my-zsh.sh
unset zle_bracketed_paste

complete -o default -o nospace -W "$(grep "^Host" $HOME/.ssh/config | cut -d" " -f2)" scp sftp ssh