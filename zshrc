#!/usr/bin/env zsh
#
# This is my main zsh configuration.
# It loads scripts from zsh/ and oh-my-zsh/

# First, show a gentle cow
fortune | cowsay

# Absolute path this script is in
dotfiles=$HOME/data/workspace/dotfiles

# Load all of the config files in oh-my-zsh that end in .zsh
for config_file ($dotfiles/oh-my-zsh/lib/*.zsh) source $config_file

# Load all of my zsh files in zsh/
for zsh_file ($dotfiles/zsh/*.zsh) source $zsh_file

# Add fish-like history search (https://github.com/sunaku/zsh-history-substring-search)
source $dotfiles/zsh/history-substring-search/zsh-history-substring-search.plugin.zsh

# Enable completion after all plugins are loaded
autoload -U compinit
compinit -i

# Load private configuration
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
