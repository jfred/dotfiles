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
brew install zsh
brew link zsh
brew install bat
brew install ranger

brew install tree

brew install zsh
brew install git
brew install python
brew install ruby

brew install lynx
brew install pv
brew install zopfli
brew install pstree
brew install ctags
brew install fzf
brew install ripgrep

brew install vim

# config
brew install autoenv

# tmux
brew install tmux
brew install reattach-to-user-namespace

brew install imagemagick

brew install direnv

# Install native apps
echo Installing applications...

brew install --cask iterm2

brew install --cask macdown
brew install --cask google-chrome

brew install --cask sourcetree

brew install --cask hammerspoon

echo Installing fonts...

brew tap homebrew/cask-fonts

brew install --cask font-inconsolata
brew install --cask font-jetbrains-mono

# Upgrade any already installed
brew upgrade

# Remove outdated versions from the cellar
echo Homebrew cleanup...
brew cleanup
