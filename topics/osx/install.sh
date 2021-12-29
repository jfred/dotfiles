#!/usr/bin/env bash
set -e

BASEDIR=$(dirname $0)
# base system settings
$BASEDIR/settings.sh

cd $BASEDIR

# Make sure we’re using the latest Home
echo Updating homebrew...
brew update

echo "Installing homebrew formulas and casks..."
brew bundle install

echo Upgrading existing homebrew formulas...
brew upgrade

# Remove outdated versions from the cellar
echo Homebrew cleanup...
brew cleanup
