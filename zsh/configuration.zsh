#!/usr/bin/env zsh
#
# Exports and oh-my-zsh configuration

# Export common variables
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$DOTFILES/scripts:$PATH"

export BROWSER="firefox"
export EDITOR='vim'
export GIT_EDITOR='vim'

# Java/SBT configuration
# export JAVA_OPTS="-Dfile.encoding=UTF8 -Xms256M -Xmx4G -Xss4M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=4G"
export JAVA_OPTS="-Xms256M -Xmx1G -Xss8M -XX:MaxPermSize=1G -XX:ReservedCodeCacheSize=512m -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC"
export SBT_OPTS=$JAVA_OPTS

# oh-my-zsh configuration
export DISABLE_AUTO_TITLE="true"

# Enable more syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# CDPATH tells the cd command to look in
# this colon-separated list of directories for your destination.
CDPATH=$HOME:..

# Load less keys
lesskey "$DOTFILES/lesskeys"

# Disable flow control in rxvt, frees ctrl-s & ctrl-q mappings
stty -ixon -ixoff

# Add dircolors
eval $(dircolors $DOTFILES/zsh/dircolors-solarized/dircolors.ansi-dark)

eval `keychain --eval --agents ssh --nogui -Q -q id_rsa`
