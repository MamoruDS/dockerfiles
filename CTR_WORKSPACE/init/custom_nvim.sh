# !/bin/sh

USERNAME=$1
if [ -z $USERNAME ]; then
    USERNAME=$(whoami)
fi
SHELL=$2

HOME=/home/$USERNAME

curl -sL https://raw.githubusercontent.com/MamoruDS/vimrc/main/install.sh | sh

cat << EOF > $HOME/update_custom_nvim_profile.sh
# !/bin/sh
curl -sL https://raw.githubusercontent.com/MamoruDS/vimrc/main/update.sh | bash && echo "done."
EOF
