#!/usr/bin/env bash
set -e

BASEDIR=$(dirname "$0")
# base system settings
"$BASEDIR"/settings.sh

cd "$BASEDIR"

# Make sure we’re using the latest Home
echo Updating homebrew...
brew update

# Note: Brewfiles are now handled by the main install.sh script
# which combines all Brewfiles and runs them once to avoid duplication
# The osx-specific Brewfile and Brewfile-apps are included in that process

echo Upgrading existing homebrew formulas...
brew upgrade

# Remove outdated versions from the cellar
echo Homebrew cleanup...
brew cleanup
