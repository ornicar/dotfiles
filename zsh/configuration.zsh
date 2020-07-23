#!/usr/bin/env zsh
#
# Exports and oh-my-zsh configuration

# Export common variables
path+="$HOME/.bin:$PATH"
# path+="$HOME/.local/bin:$PATH" # crashes ZSH!!!
path+="$DOTFILES/scripts:$PATH"

export TERMINAL="alacritty"
export BROWSER="chromium"
export EDITOR='nvim'
export GIT_EDITOR='nvim'
export FZF_DEFAULT_COMMAND='ag --silent --hidden --unrestricted --nocolor --ignore .git -g ""'

# Java/SBT configuration
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk/
export SBT_OPTS="-Xms128M -Xmx512M -Xss1m"
# export SBT_OPTS="-Xms64M -Xmx2048M -Xss4M -XX:ReservedCodeCacheSize=64m -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC"
# export SBT_OPTS="-Xms64M -Xmx512M -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC"

# oh-my-zsh configuration
export DISABLE_AUTO_TITLE="true"

# Enable more syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# CDPATH tells the cd command to look in
# this colon-separated list of directories for your destination.
CDPATH=$HOME:..

# Load less keys
lesskey "$DOTFILES/lesskeys"

# Add dircolors
eval $(dircolors $DOTFILES/zsh/dircolors-solarized/dircolors.ansi-dark)

eval `keychain --eval --agents ssh --nogui -Q -q id_rsa`
