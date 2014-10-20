#!/usr/bin/env bash
set -e

# base system settings
./settings.sh

# install base packages
./homebrew_install.sh

# hydra
open "https://github.com/sdegutis/hydra/releases"
