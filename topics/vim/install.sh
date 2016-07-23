#!/usr/bin/env bash
set -e

# commit hash of vim-plug
COMMIT_HASH=e15598fe4567e4cdbcbc4aea2d8b0d0f75a7254f
BASEDIR=$(dirname $0)

LATEST_HASH=$(git ls-remote https://github.com/junegunn/vim-plug | grep master | awk '{ print $1}')

if [ "${LATEST_HASH}" != "${COMMIT_HASH}" ]; then
    echo "WARNING: vim-plug has been updated - latest commit: ${LATEST_HASH}"
fi

mkdir -p ~/.vim/autoload
target=~/.vim/autoload/plug.vim
tmpfile=$(mktemp /tmp/plug.vim.XXXXXX)
curl -fLo ${tmpfile} https://raw.githubusercontent.com/junegunn/vim-plug/${COMMIT_HASH}/plug.vim > /dev/null 2>&1
if ! cmp --silent ${tmpfile} ${target}; then
    echo Setting plug.vim to ${COMMIT_HASH}
    mv ${tmpfile} ${target}
fi
rm -f "$tmpfile"

(cd ${BASEDIR} && vim -u vimrc_load +PlugClean! +PlugUpdate +UpdateRemotePlugins +qa!)
