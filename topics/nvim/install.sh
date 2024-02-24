#!/usr/bin/env bash
set -e

BASEDIR=$(dirname $0)

cd $BASEDIR
if ! test -d ~/.config/nvim; then
    mkdir -p ~/.config
    ln -s $(pwd)/config ~/.config/nvim
fi

# commit hash of vim-plug
COMMIT_HASH=$(awk '{printf $0}' vim-plug.commit)

LATEST_HASH=$(git ls-remote https://github.com/junegunn/vim-plug | grep master | awk '{ print $1}')

if [ "${LATEST_HASH}" != "${COMMIT_HASH}" ]; then
    echo "WARNING: vim-plug has been updated - latest commit: ${LATEST_HASH}"
fi

AUTOLOAD=~/.local/share/nvim/site/autoload
mkdir -p ${AUTOLOAD}
target=${AUTOLOAD}/plug.vim
tmpfile=$(mktemp /tmp/plug.vim.XXXXXX)
curl -fLo ${tmpfile} https://raw.githubusercontent.com/junegunn/vim-plug/${COMMIT_HASH}/plug.vim > /dev/null 2>&1
if ! cmp --silent ${tmpfile} ${target}; then
    echo Setting plug.vim to ${COMMIT_HASH}
    mv ${tmpfile} ${target}
fi
rm -f "$tmpfile"

nvim -u load.vim +PlugClean! +PlugUpdate +UpdateRemotePlugins +qa!
