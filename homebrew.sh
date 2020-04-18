#!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update

brew install git
brew install go
brew install zsh
brew install emacs
brew install vim
brew install tmux
brew install reattach-to-user-namespace
brew install terminal-notifier
brew install tig
brew install hub
brew install jq
brew install aspell
brew install cmigemo
brew install peco

brew cleanup
