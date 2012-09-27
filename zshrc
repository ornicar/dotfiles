#!/usr/bin/env zsh
#
# This is my main zsh configuration.
# It loads scripts from zsh/ and oh-my-zsh/

# First of all, feature a chatty cow
fortune -a | cowsay

DOTFILES=$HOME/dotfiles
OHMYZSH=$DOTFILES/oh-my-zsh

for i in 0 1 2; do
  f=/sys/class/hwmon/hwmon$i/device/fan1_input
  [[ -f $f ]] && FAN_INPUT_FILE=$f
done

# Load all of the config files in oh-my-zsh that end in .zsh
for config_file ($OHMYZSH/lib/*.zsh) source $config_file

# Load chosen oh-my-zsh plugins
for plugin in archlinux extract cap; do
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
compinit -i

# Load private configuration
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
