#!/bin/zsh

# Show a gentle cow
fortune | cowsay

export PATH=${PATH}:${HOME}/.bin
export BROWSER="chromium-browser"
export EDITOR='vim'
export GIT_EDITOR='vim -X'

# Configure oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="ornicar"
export DISABLE_AUTO_UPDATE="true"

# Run oh-my-zsh
plugins=(git vi-mode)
source $ZSH/oh-my-zsh.sh

# Start ssh key manager
keychain --quiet --agents ssh id_rsa
