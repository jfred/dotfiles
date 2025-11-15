#!/usr/bin/env bash
set -e

BASEDIR=$(dirname $0)

cd $BASEDIR
if ! test -d ~/.config/starship; then
    mkdir -p ~/.config/starship
fi

# Symlink config files
for file in config/*; do
    if [ -f "${file}" ]; then
        dest="${HOME}/.config/$(basename ${file})"
        if [ ! -e "${dest}" ]; then
            echo ln -fs "$(pwd)/${file}" "${dest}"
            ln -fs "$(pwd)/${file}" "${dest}"
            echo "${file} linked as ${dest}"
        fi
    fi
done
