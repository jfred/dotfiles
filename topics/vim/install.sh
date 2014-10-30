#!/usr/bin/env bash
set -e

BASEDIR=$(dirname $0)

mkdir -p ~/.vim/autoload
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

(cd ${BASEDIR} && vim -u vimrc_load +PlugClean! +PlugUpdate +qa!)
