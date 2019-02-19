# Make sure we’re using the latest Home
echo Updating homebrew...
brew update

# Upgrade any already-installed formulae
echo Upgrading homebrew...
brew upgrade

echo Installing base homebrew packages...
brew install coreutils
brew install moreutils
brew install gnu-sed

brew install tree

brew install zsh
brew install git
brew install python
brew install ruby
brew install --HEAD --with-lua --with-luajit macvim

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

brew install direnv

# Remove outdated versions from the cellar
echo Homebrew cleanup...
brew cleanup

# Install native apps
echo Installing applications...

brew cask install iterm2

brew cask install macdown
brew cask install google-chrome

brew cask install sourcetree

brew cask install hammerspoon
