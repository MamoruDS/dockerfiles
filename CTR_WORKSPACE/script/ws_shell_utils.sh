# v0.1.0

# functions
mkcdir() {
    mkdir -p -- "$1" && cd -P -- "$1"
}
color_test() {
    curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash
}

# SSH auto complete
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
complete -o default -o nospace -W "$(grep "^Host" $HOME/.ssh/config | cut -d" " -f2)" scp sftp ssh
