#!/bin/sh

curl -sL https://raw.githubusercontent.com/MamoruDS/dockerfiles/master/CTR_WORKSPACE/.config/zsh_theme_spaceship.sh \
    > $HOME/.config/zsh_theme_spaceship.sh

curl -sL https://raw.githubusercontent.com/MamoruDS/dockerfiles/master/CTR_WORKSPACE/.config/zsh_theme_highlight.sh \
    > $HOME/.config/zsh_theme_highlight.sh

echo 'done'
