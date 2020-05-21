FROM ubuntu:20.04

LABEL maintainer="MamoruDS <mamoruds.io@gmail.com>"

ARG TZ=Asia/Tokyo
ARG USERNAME=ctr 

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    git \
    sudo \
    zsh \
    openssh-server \
    curl \
    dnsutils \
    iputils-ping \
    tmux \
    # changing to vim nano ...etc
    neovim

# installation of node 12.x
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt install -y nodejs

# user set up
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && useradd -ms /bin/zsh $USERNAME \
    && usermod -aG sudo $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && echo "Set disable_coredump false" >> /etc/sudo.conf

USER $USERNAME
WORKDIR /home/${USERNAME}

# vim set up
# RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o oh_my_zsh.sh \
    && zsh oh_my_zsh.sh --unattended \
    && rm oh_my_zsh.sh
ARG ZSH_CUSTOM="/home/$USERNAME/.oh-my-zsh/custom"
RUN git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" \
    && ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" \
    && sed 's/ZSH_THEME="AR2"/ZSH_THEME="spaceship"/' \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
ADD .zshrc /home/${USERNAME}/.zshrc
ADD .tmux.conf /home/${USERNAME}/.tmux.conf

# installation of miniconda
RUN curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh \
    && sh miniconda.sh -b -p /home/${USERNAME}/miniconda \
    && /home/${USERNAME}/miniconda/bin/conda init zsh \
    && /home/${USERNAME}/miniconda/bin/conda config --set auto_activate_base false \
    && rm miniconda.sh

RUN mkdir -p /home/${USERNAME}/WORKSPACE \
    && mkdir -p /home/${USERNAME}/.vscode_server \
    && mkdir -p /home/${USERNAME}/.ssh
ADD keys/ /home/${USERNAME}/.ssh/

ADD init.sh /home/${USERNAME}/init.sh
RUN echo ${USERNAME} > /home/${USERNAME}/.user \
    && sudo chmod +x /home/${USERNAME}/init.sh \
    && sudo chown ${USERNAME} /home/${USERNAME}/init.sh

EXPOSE 22

CMD sh init.sh $(cat .user) && sudo service ssh start && tail -f /dev/null