#!/usr/bin/env bash
set -e

BASEDIR=$(dirname "$0")
# base system settings
"$BASEDIR"/settings.sh

cd "$BASEDIR"

# Make sure we’re using the latest Home
echo Updating homebrew...
brew update

echo "Installing osx Brewfile..."
brew bundle install

echo "Installing osx Brewfile-apps..."
brew bundle install --file="Brewfile-apps"

# Create links
LINKS=$(find .. -name 'Brewfile')
for filename in ${LINKS}; do
    if [[ ${filename} =~ "osx" ]]; then
        continue
    fi
    if [[ ${filename} =~ ${DOT_EXCLUDE} ]]; then
        # echo "Skipping ${filename}"
        continue
    fi
    echo "${filename}" | sed -e 's/\.\.\/\(.*\)\/Brewfile/Installing \1 Brewfile.../g'
    brew bundle install --file="${filename}"
done

echo Upgrading existing homebrew formulas...
brew upgrade

# Remove outdated versions from the cellar
echo Homebrew cleanup...
brew cleanup
