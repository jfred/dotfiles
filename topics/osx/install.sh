#!/usr/bin/env bash
set -e

# base system settings
./settings.sh
# install base packages
brew bundle Brewfile
# install core osx apps
brew bundle Caskfile

# hydra
open "https://github.com/sdegutis/hydra/releases"
