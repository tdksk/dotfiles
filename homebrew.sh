#!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update

brew install git
brew install zsh
brew install emacs
brew install tmux
brew install reattach-to-user-namespace
brew install terminal-notifier
brew install tig
brew install hub
brew install wget
brew install the_silver_searcher
brew install jq
brew install aspell --lang=en
brew install cmigemo
brew install autossh

brew tap peco/peco
brew install peco

brew cleanup
