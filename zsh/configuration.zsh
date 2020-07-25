#!/usr/bin/env zsh
#
HISTFILE=~/.zsh_history
HISTSIZE=90000
SAVEHIST=90000
setopt SHARE_HISTORY

# Export common variables
path+="$HOME/.bin:$PATH"
# path+="$HOME/.local/bin:$PATH" # crashes ZSH!!!

export TERMINAL="alacritty"
export BROWSER="chromium"
export EDITOR='nvim'
export GIT_EDITOR='nvim'

export JAVA_HOME=/usr/lib/jvm/java-11-graalvmee
export SBT_OPTS="-Xms128M -Xmx512M -Xss1m"
# export SBT_OPTS="-Xms64M -Xmx2048M -Xss4M -XX:ReservedCodeCacheSize=64m -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC"
# export SBT_OPTS="-Xms64M -Xmx512M -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC"

# CDPATH tells the cd command to look in
# this colon-separated list of directories for your destination.
CDPATH=$HOME:..

# Load less keys
lesskey "$DOTFILES/lesskeys"

eval `keychain --eval --agents ssh --nogui -Q -q id_rsa`
