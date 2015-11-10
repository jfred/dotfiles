#!/usr/bin/env bash
set -e

# create neovim aliases
if [ ! -e ~/.config ]; then
    mkdir ~/.config
fi
if [ ! -e ~/.config/nvim ]; then
    ln -s ~/.vim ~/.config/nvim
fi
if [ ! -e ~/.config/nvim/init.vim ]; then
    ln -s ~/.vimrc ~/.config/nvim/init.vim
fi

# install python support
pip2 install --user neovim
