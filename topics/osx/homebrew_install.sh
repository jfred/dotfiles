# Make sure we’re using the latest Home
brew update

# Upgrade any already-installed formulae
brew upgrade

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

# config
brew install autoenv

# tmux
brew install tmux
brew install reattach-to-user-namespace

brew install imagemagick --with-webp

brew install lua
brew install luarocks

# Remove outdated versions from the cellar
brew cleanup

# Install native apps

brew install phinze/cask/brew-cask
brew tap caskroom/versions

brew cask install quicksilver
brew cask install iterm2

brew cask install mou
brew cask install google-chrome

brew cask install gitx-rowanj

brew cask install mjolnir
