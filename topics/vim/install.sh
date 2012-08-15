#!/usr/bin/env bash
set -e

mkdir -p ~/.vim/bundle

if [ ! -d ~/.vim/bundle/vundle ]; then
    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

vim -u topics/vim/vimrc_load +BundleInstall +BundleClean +qa!
