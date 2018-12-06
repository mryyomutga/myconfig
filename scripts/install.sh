#!/bin/sh
# command check
set -e

password_read(){
    if ! ${password+:} false; then
        printf "password : "
        read -s password
        echo
    fi
}

packages=""
if ! type git > /dev/null 2>&1; then
    echo "git is not installed."
    packages="${packages}git "
fi
if ! type xsel > /dev/null 2>&1; then
    echo "xsel is not installed."
    packages="${packages}xsel "
fi
if ! type curl > /dev/null 2>&1; then
    echo "curl is not installed."
    packages="${packages}curl "
fi
if ! type wget > /dev/null 2>&1; then
    echo "wget is not installed."
    packages="${packages}wget "
fi
if ! type vim > /dev/null 2>&1; then
    echo "vim is not installed."
    packages="${packages}vim "
fi
if ! type fzf > /dev/null 2>&1; then
    echo "fzf is not installed."
    packages="${packages}fzf"
fi
# check "not installed packages" and install
if [ "$packages" != "" ]; then
    password_read
    echo "$password" | sudo -S pacman -Sy --noconfirm $packages
fi
# clone dotfiles
if [ ! -e ${HOME}/.dotfiles ]; then
    git clone https://github.com/mryyomutga/dotfiles.git ${HOME}/.dotfiles
    echo ""
fi

# fzf
# if [ ! -e ${HOME}.fzf ]; then
#     git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
#     sh ~/.fzf/install
# fi

#  install zsh-syntax-highlighting
if [ ! -e ${HOME}/.dotfiles/src/zsh/.zsh-syntax-highlighting ]; then
    echo "\"${HOME}/.dotfiles/zsh/.zsh-syntax-highlighting\" is not found."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.dotfiles/zsh/.zsh-syntax-highlighting
    echo ""
fi

# install zsh-autosuggestions
if [ ! -e ${HOME}/.dotfiles/zsh/.zsh-autosuggestions ]; then
    echo "\"${HOME}/.dotfiles/src/zsh/.zsh-autosuggestions\" is not found."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/.dotfiles/zsh/.zsh-autosuggestions
    echo ""
fi

# install vim plugins
if [ ! -e ${HOME}/.dotfiles/vim/plugins/repos/github.com/Shougo/dein.vim ]; then
    echo "\"${HOME}/.dotfiles/src/.config/nvim/plugins/repos/github.com/Shougo/dein.vim\" is not found."
    mkdir -p ${HOME}/.dotfiles/src/.config/nvim/plugins/repos/github.com/Shougo/dein.vim
    git clone https://github.com/Shougo/dein.vim.git ${HOME}/.dotfiles/.config/nvim/plugins/repos/github.com/Shougo/dein.vim
    echo ""
fi

# make zsh history file
echo "make zsh history"
touch ${HOME}/.zsh_history

# make synbolic link
## rc file
# if [ ! -e ${HOME}/.zshrc ]; then
#     echo "link ${HOME}/.dotfiles/src/.zshrc -> ${HOME}/.zshrc"
#     ln -s ${HOME}/.dotfiles/.zshrc ${HOME}/.zshrc
# fi
if [ ! -e ${HOME}/.zshenv ]; then
    echo "link ${HOME}/.dotfiles/zsh/.zshenv -> ${HOME}/.zshenv"
    ln -s ${HOME}/.dotfiles/zsh/.zshenv ${HOME}/.zshenv
fi
if [ ! -e ${HOME}/.vimrc ]; then
    echo "link ${HOME}/.dotfiles/.vimrc -> ${HOME}/.vimrc"
    ln -s ${HOME}/.dotfiles/vim/init.vim ${HOME}/.vimrc
fi
if [ ! -e ${HOME}/.tigrc ]; then
    echo "link ${HOME}/.dotfiles/.tigrc -> ${HOME}/.tigrc"
    ln -s ${HOME}/.dotfiles/.tigrc ${HOME}/.tigrc
fi
if [ ! -e ${HOME}/.tmux.conf ]; then
    echo "link ${HOME}/.dotfiles/.tmux.conf -> ${HOME}/.tmux.conf"
    ln -s ${HOME}/.dotfiles/tmux/.tmux.conf ${HOME}/.tmux.conf
fi
if [ ! -e ${HOME}/.config/nvim ]; then
    echo "${HOME}/.config/nvim is not found. make link to ${HOME}/.config/nvim"
    ln -s ${HOME}/.dotfiles/.config/nvim ${HOME}/.config/nvim
fi

## self made command
# echo "${HOME}/.dotfiles/zsh/display_off ${HOME}/.display_off"
# cp -r ${HOME}/.dotfiles/zsh/display_off ${HOME}/.display_off

## config
if [ ! -e ${HOME}/.config/alacritty ]; then
    echo "Not found ${HOME}/.config/alaritty/alacritty.yml"
    echo "link to ${HOME}/.config/alacritty"
    ln -s ${HOME}/.dotfiles/.config/alacritty ${HOME}/.config/alacritty
fi

if [ ! -e ${HOME}/.config/peco ]; then
    echo "Not found ${HOME}/.config/peco"
    echo "link to ${HOME}/.config/peco"
    ln -s ${HOME}/.dotfiles/.config/peco ${HOME}/.config/peco
fi
