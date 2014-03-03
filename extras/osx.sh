#!/usr/bin/env bash
set -e

brew update
brew install coreutils --default-names
brew install zsh
brew install git
brew install python
brew install ruby
brew install --HEAD macvim

# config
brew install autoenv

# tmux
brew install tmux
brew install reattach-to-user-namespace
