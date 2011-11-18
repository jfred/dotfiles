#!/usr/bin/env bash
set -e

mkdir -p ~/.vim/bundle

if [ ! -d ~/.vim/bundle/vundle ]; then
    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

echo ""
echo "*************************************************************"
echo "* About to setup vundle (quit vim ':qa!') after it finishes *"
echo "*************************************************************"
sleep 2
vim -u topics/vim/vimrc_load -c 'BundleInstall'
