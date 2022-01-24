# !/bin/sh
# v0.1.1

cdr() {
    cd $(git rev-parse --show-toplevel)
}

color_test() {
    curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash
}

mkcdir() {
    mkdir -p -- "$1" && cd -P -- "$1"
}

# SSH auto complete
if [ ! -d "$HOME/.ssh" ]; then
    mkdir -p $HOME/.ssh
    touch $HOME/.ssh/config
fi
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
complete -o default -o nospace -W "$(grep "^Host" $HOME/.ssh/config | cut -d" " -f2)" scp sftp ssh
