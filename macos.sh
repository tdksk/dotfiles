#!/bin/sh

defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1
defaults write -g NSNavPanelExpandedStateForSaveMode -boolean true
defaults write -g NSScrollAnimationEnabled -bool false
defaults write com.apple.dashboard mcx-disabled -boolean true
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.Dock autohide-delay -float 0
defaults write com.apple.finder _FXShowPosixPathInTitle -boolean true
defaults write com.apple.finder AppleShowAllFiles true
defaults write com.apple.finder QLEnableTextSelection -bool true
defaults write com.apple.screencapture name "SS"
