#!/usr/bin/env zsh
#
# This is my main zsh configuration.
# It loads scripts from zsh/ and oh-my-zsh/

# First of all, feature a chatty cow
fortune | cowsay

# Absolute path this script is in
DOTFILES=$HOME/dotfiles

# Load all of the config files in oh-my-zsh that end in .zsh
for config_file ($DOTFILES/oh-my-zsh/lib/*.zsh) source $config_file

# Load chosen oh-my-zsh plugins
for plugin in archlinux extract; do
    source $DOTFILES/oh-my-zsh/plugins/$plugin/$plugin.plugin.zsh
done

# Load all of my zsh files in zsh/
for zsh_file ($DOTFILES/zsh/*.zsh) source $zsh_file

# Add fish-like syntax highlighting 
source $DOTFILES/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh

# Add fish-like history search 
source $DOTFILES/zsh/history-substring-search/zsh-history-substring-search.zsh

# Enable completion after all plugins are loaded
autoload -U compinit
compinit -i

# Load private configuration
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
