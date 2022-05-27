#!/usr/bin/env zsh

HISTFILE=~/.zsh_history
HISTSIZE=90000
SAVEHIST=90000
setopt SHARE_HISTORY

# Export common variables
path+="$HOME/.bin:$PATH"
path+="$HOME/.local/share/coursier/bin"
# path+="$HOME/.local/bin:$PATH" # crashes ZSH!!!

export TERMINAL="alacritty"
export BROWSER="google-chrome-stable"
export CHROME_EXECUTABLE="google-chrome-stable"
export EDITOR='nvim'
export GIT_EDITOR="nvim -u ~/dotfiles/nvim/gitcommit.init.vim"

export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=default'"

export JAVA_HOME=/usr/lib/jvm/java-11-graalvm
export SBT_OPTS="-Xms256M -Xmx4G"

export QT_QPA_PLATFORMTHEME=qt5ct

# CDPATH tells the cd command to look in
# this colon-separated list of directories for your destination.
CDPATH=$HOME:..

eval `keychain --eval --agents ssh --nogui -Q -q id_rsa`

# autocompletion
autoload -Uz compinit
compinit

# complete case insensitive (https://stackoverflow.com/questions/13424429/can-zsh-do-smartcase-completion-like-vims-search)
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

# complete sudo commands
zstyle ':completion::complete:*' gain-privileges 1

# cd without cd
setopt autocd autopushd
