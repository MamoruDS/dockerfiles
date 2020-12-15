typeset -A ZSH_HIGHLIGHT_STYLES

# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md

ZSH_HIGHLIGHT_STYLES_PRESET_ARG0='fg=7,bold'

ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=255,bg=9,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]=$ZSH_HIGHLIGHT_STYLES_PRESET_ARG0
ZSH_HIGHLIGHT_STYLES[alias]=$ZSH_HIGHLIGHT_STYLES_PRESET_ARG0
ZSH_HIGHLIGHT_STYLES[suffix-alias]=$ZSH_HIGHLIGHT_STYLES_PRESET_ARG0
ZSH_HIGHLIGHT_STYLES[builtin]=$ZSH_HIGHLIGHT_STYLES_PRESET_ARG0
ZSH_HIGHLIGHT_STYLES[function]=$ZSH_HIGHLIGHT_STYLES_PRESET_ARG0
ZSH_HIGHLIGHT_STYLES[command]=$ZSH_HIGHLIGHT_STYLES_PRESET_ARG0
ZSH_HIGHLIGHT_STYLES[precommand]=$ZSH_HIGHLIGHT_STYLES_PRESET_ARG0
ZSH_HIGHLIGHT_STYLES[path]='fg=15,bg=8,bold'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=11,bg=8,bold'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=15,bg=8,underline,bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=12,bold'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=11,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=11,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=10,bold'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=10,bold'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=10,bold'
ZSH_HIGHLIGHT_STYLES[assign]='fg=9,bold'
ZSH_HIGHLIGHT_STYLES[comment]='fg=black,bold'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=11,bold'
ZSH_HIGHLIGHT_STYLES[default]='fg=255,bold'
