#!/usr/bin/env bash
set -e

brew update
brew install coreutils
brew install zsh
brew install git
brew install python
brew install ruby
brew install --HEAD macvim

# tmux
brew install tmux
brew install reattach-to-user-namespace
