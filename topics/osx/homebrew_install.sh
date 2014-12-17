# Make sure we’re using the latest Home
echo Updating homebrew...
brew update

# Upgrade any already-installed formulae
echo Upgrading homebrew...
brew upgrade

echo Installing base homebrew packages...
brew install coreutils --default-names
brew install moreutils
brew install gnu-sed --default-names

brew install tree

brew install zsh
brew install git
brew install python
brew install ruby
brew install --HEAD macvim

brew install lynx
brew install pv
brew install zopfli
brew install pstree
brew install ctags

# config
brew install autoenv

# tmux
brew install tmux
brew install reattach-to-user-namespace

brew install imagemagick --with-webp

brew install lua
brew install luarocks

# Remove outdated versions from the cellar
echo Homebrew cleanup...
brew cleanup

# Install native apps
echo Installing applications via brew-cask...

brew install caskroom/cask/brew-cask

brew cask install quicksilver
brew cask install iterm2

brew cask install mou
brew cask install google-chrome

brew cask install sourcetree

brew cask install mjolnir
luarocks install mjolnir.alert
luarocks install mjolnir.hotkey
luarocks install mjolnir.application

