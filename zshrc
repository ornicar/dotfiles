#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
#
# This is my main zsh configuration.
# Loads scripts from zsh/ and oh-my-zsh/

# First, show a gentle cow
fortune | cowsay

# Absolute path this script is in
dotfiles=$HOME/data/workspace/dotfiles

# Exports and configuration
source $dotfiles/zsh/configuration.zsh

# Load all of the config files in oh-my-zsh that end in .zsh
for config_file ($dotfiles/oh-my-zsh/lib/*.zsh) source $config_file

# Load the theme
source $dotfiles/zsh/ornicar.zsh-theme

# Add fish-like history search (https://github.com/sunaku/zsh-history-substring-search)
source $dotfiles/zsh/history-substring-search/zsh-history-substring-search.plugin.zsh

# Add vi-like mappings
source $dotfiles/zsh/vi-mappings.zsh

# Git alias
source $dotfiles/zsh/git-alias.zsh

# Git functions
source $dotfiles/zsh/git-functions.zsh

# Misc alias
source $dotfiles/zsh/misc-alias.zsh

# Misc functions
source $dotfiles/zsh/misc-functions.zsh

# Load less keys
lesskey "$dotfiles/lesskeys"

# Load private configuration
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
