#!/usr/bin/env bash
set -e

BASEDIR=$(dirname $0)

cd $BASEDIR
if ! test -d ~/.config/git; then
    mkdir -p ~/.config
    ln -s $(pwd)/config ~/.config/git
fi