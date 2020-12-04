#!/usr/bin/env bash
set -e

TARGET=~/.tmux/plugins/tpm
SOURCE=https://github.com/tmux-plugins/tpm

if [ -d ${TARGET} ]; then
    cd ${TARGET}
    git pull
else
    git clone ${SOURCE} ${TARGET}
fi

