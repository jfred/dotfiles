#!/usr/bin/env bash
set -e

BASEDIR=$(dirname $0)

cd $BASEDIR
if ! test -f ~/.config/nvim; then
    mkdir -p ~/.config
    ln -s $(pwd)/config ~/.config/nvim
fi

