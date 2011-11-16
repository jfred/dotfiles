#!/usr/bin/env bash
set -e

mkdir -p ~/.vim/bundle

git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

vim -c 'BundleInstall'
