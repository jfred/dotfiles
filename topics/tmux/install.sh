#!/usr/bin/env bash
set -e

# Use XDG config directory for tmux
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
TARGET="${XDG_CONFIG_HOME}/tmux/plugins/tpm"
SOURCE=https://github.com/tmux-plugins/tpm

if [ -d "${TARGET}" ]; then
    (cd "${TARGET}" && git pull)
else
    mkdir -p "$(dirname "${TARGET}")"
    git clone "${SOURCE}" "${TARGET}"
fi

# Clean up old TPM location if it exists and is not a symlink
OLD_TARGET="$HOME/.tmux/plugins/tpm"
if [ -d "${OLD_TARGET}" ] && [ ! -L "${OLD_TARGET}" ]; then
    echo "Note: Old TPM directory exists at ${OLD_TARGET}"
    echo "You may want to remove it manually after verifying the new location works."
fi

