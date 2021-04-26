SPACESHIP_PROMPT_ORDER=(
    user # Username section
    host # Hostname section
    dir  # Current directory section
    conda # conda virtualenv section
    git  # Git section (git_branch + git_status)
    # hg      # Mercurial section (hg_branch  + hg_status)
    package # Package version
    # node          # Node.js section
    # ruby   # Ruby section
    # elixir # Elixir section
    # xcode  # Xcode section
    # swift  # Swift section
    # golang # Go section
    # php    # PHP section
    # rust          # Rust section
    # haskell # Haskell Stack section
    # julia   # Julia section
    # docker        # Docker section
    # aws   # Amazon Web Services section
    # venv  # virtualenv section
    # pyenv         # Pyenv section
    # dotnet      # .NET section
    # ember       # Ember.js section
    # kubecontext # Kubectl context section
    exec_time   # Execution time
    time     # Time stampts section
    line_sep # Line break
    # battery     # Battery level and status
    # vi_mode     # Vi-mode indicator
    jobs      # Background jobs indicator
    exit_code # Exit code section
    char      # Prompt character
)

# Char
SPACESHIP_CHAR_SYMBOL=': '
SPACESHIP_CHAR_SYMBOL_ROOT='$ '
SPACESHIP_CHAR_COLOR_SUCCESS='0'
SPACESHIP_CHAR_COLOR_FAILURE='9'
SPACESHIP_CHAR_COLOR_SECONDARY='11'

# User
SPACESHIP_USER_SHOW='true'
# SPACESHIP_USER_PREFIX='with '
# SPACESHIP_USER_SUFFIX=
SPACESHIP_USER_COLOR='3'
SPACESHIP_USER_COLOR_SSH='3'

# Hostname
SPACESHIP_HOST_SHOW='true'
SPACESHIP_HOST_SHOW_FULL='false'
SPACESHIP_HOST_PREFIX='au '
# SPACESHIP_HOST_SUFFIX=
SPACESHIP_HOST_COLOR='6'
SPACESHIP_HOST_COLOR_SSH='6'

# Directory
# SPACESHIP_DIR_SHOW='true'
# SPACESHIP_DIR_PREFIX='in '
# SPACESHIP_DIR_TRUNC='3'
# SPACESHIP_DIR_TRUNC_PREFIX=' '
# SPACESHIP_DIR_TRUNC_REPO='true'
SPACESHIP_DIR_COLOR='15' #"magenta"
# SPACESHIP_DIR_LOCK_SYMBOL=
# SPACESHIP_DIR_LOCK_COLOR='red'

# Git
SPACESHIP_GIT_SHOW='true'
SPACESHIP_GIT_PREFIX='au '
# SPACESHIP_GIT_SUFFIX=
# SPACESHIP_GIT_SYMBOL=
SPACESHIP_GIT_BRANCH_SHOW='true'
SPACESHIP_GIT_BRANCH_COLOR='182'
SPACESHIP_GIT_STATUS_SHOW='true'
SPACESHIP_GIT_STATUS_PREFIX=' ['
SPACESHIP_GIT_STATUS_SUFFIX=']'
SPACESHIP_GIT_STATUS_COLOR='183'
SPACESHIP_GIT_STATUS_UNTRACKED='?'
SPACESHIP_GIT_STATUS_ADDED='+'
SPACESHIP_GIT_STATUS_MODIFIED='!'
SPACESHIP_GIT_STATUS_RENAMEDE='»'
SPACESHIP_GIT_STATUS_DELETED='✘'
SPACESHIP_GIT_STATUS_STASHED='$'
SPACESHIP_GIT_STATUS_UNMERGED='='
SPACESHIP_GIT_STATUS_AHEAD='⇡'
SPACESHIP_GIT_STATUS_BEHIND='⇣'
SPACESHIP_GIT_STATUS_DIVERGED='⇕'

# Package
SPACESHIP_PACKAGE_PREFIX=''
SPACESHIP_PACKAGE_SYMBOL=''
SPACESHIP_PACKAGE_COLOR='115'

# Time
SPACESHIP_TIME_SHOW='true'
SPACESHIP_TIME_PREFIX=''
SPACESHIP_TIME_SUFFIX=' '
SPACESHIP_TIME_FORMAT='%*'
SPACESHIP_TIME_COLOR='0'

# Conda Virtualenv (conda)
SPACESHIP_CONDA_SHOW='true'
SPACESHIP_CONDA_PREFIX='@'
SPACESHIP_CONDA_SUFFIX=' '
SPACESHIP_CONDA_SYMBOL=''
SPACESHIP_CONDA_COLOR='81'
SPACESHIP_CONDA_VERBOSE='true'

# Execution time
SPACESHIP_EXEC_TIME_PREFIX=''
SPACESHIP_EXEC_TIME_COLOR='216'

# Tmux
if [ -z "$TMUX" -a -z "$VSCODE_INTEGRATED_TERMINAL" ]; then
    SPACESHIP_USER_SHOW='true'
    SPACESHIP_HOST_SHOW='true'
else
    SPACESHIP_USER_SHOW='false'
    SPACESHIP_HOST_SHOW='false'
fi
