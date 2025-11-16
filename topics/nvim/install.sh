#!/usr/bin/env bash
set -e

BASEDIR=$(dirname $0)

cd $BASEDIR

# Create nvim config symlink if it doesn't exist
if ! test -d ~/.config/nvim; then
    mkdir -p ~/.config
    ln -s $(pwd)/config ~/.config/nvim
fi

echo "Neovim configured with lazy.nvim"
echo "Plugins will be installed automatically on first launch"
echo ""
echo "Run: nvim"
echo "  - lazy.nvim will auto-install on first launch"
echo "  - Plugins will be downloaded automatically"
echo ""
echo "Useful lazy.nvim commands:"
echo "  :Lazy - Open lazy.nvim UI"
echo "  :Lazy sync - Install/update/clean plugins"
echo "  :Lazy update - Update plugins"
echo "  :Lazy clean - Remove unused plugins"
