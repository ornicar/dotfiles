#!/bin/zsh

export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="ornicar"
export DISABLE_AUTO_UPDATE="true"
export PATH=${PATH}:${HOME}/.bin
export BROWSER="chromium-browser"

plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'
export GIT_EDITOR='vim -X'

# Show a gentle cow
fortune | cowsay

# Prepare keychain
alias kc="eval `keychain --eval --agents ssh id_rsa`"
