# !/bin/sh
git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_NAME

sudo chown $1 ~/.vscode_server
sudo chown $1 ~/.zshrc
sudo chown $1 ~/.tmux.conf
sudo chown $1 -hR ~/.ssh
