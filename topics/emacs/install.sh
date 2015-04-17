#!/usr/bin/env bash
set -e

platform=`uname -o 2> /dev/null || uname`

# install emaacs
if [[ $platform == 'Darwin' ]]; then
    brew tap railwaycat/emacsmacport
    brew install emacs-mac
fi

if [ ! -d "~/.emacs.d" ]; then
    git clone --recursive http://github.com/syl20bnr/spacemacs ~/.emacs.d
fi
