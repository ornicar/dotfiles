#!/usr/bin/env zsh
#
# This is my main zsh configuration.
# It loads scripts from zsh/ and oh-my-zsh/

# First of all, feature a chatty cow
fortune -a | cowsay

DOTFILES=$HOME/dotfiles
OHMYZSH=$DOTFILES/oh-my-zsh

# Load all of the config files in oh-my-zsh that end in .zsh
for config_file ($OHMYZSH/lib/*.zsh) source $config_file

# Load chosen oh-my-zsh plugins
for plugin in archlinux; do
  source $OHMYZSH/plugins/$plugin/$plugin.plugin.zsh
done

# Load all of my zsh files in zsh/
for zsh_file ($DOTFILES/zsh/*.zsh) source $zsh_file

# Add fish-like syntax highlighting (must be done before substring search!)
source $DOTFILES/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh

# Add history substring search
source $DOTFILES/zsh/history-substring-search/zsh-history-substring-search.zsh

# Enable completion after all plugins are loaded
autoload -U compinit
fpath=($DOTFILES/zsh/cabal-completion $fpath)
compinit -i

source $OHMYZSH/plugins/cabal/cabal.plugin.zsh

# Load private configuration
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
