#!/usr/bin/env zsh
#
# Exports and oh-my-zsh configuration

# Export common variables
export PATH="$HOME/bin:$PATH"
export PATH="$DOTFILES/scripts:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH=$PATH:/home/thib/play-2.0
#export PATH=$PATH:/home/thib/bin/play2

export BROWSER="firefox-beta-bin"
export EDITOR='vim'
export GIT_EDITOR='vim'

# Java/SBT configuration
export SBT_OPTS="-Dfile.encoding=UTF8 -Xms256M -Xmx2048M -Xss4M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=2048M"
#export SBT_OPTS="-Dfile.encoding=UTF8 -Xms256M -Xmx512M -Xss2M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=512M -XX:+HeapDumpOnOutOfMemoryError"

#export SBT_OPTS_CHEAP="-Dfile.encoding=UTF8 -Xms64M -Xmx128M -Xss2M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=64M"

export _JAVA_AWT_WM_NONREPARENTING=1

# oh-my-zsh configuration
export DISABLE_AUTO_TITLE="true"

# Enable more syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# CDPATH tells the cd command to look in
# this colon-separated list of directories for your destination.
CDPATH=$HOME:..:/etc

# Load less keys
lesskey "$DOTFILES/lesskeys"

# Disable flow control in rxvt, frees ctrl-s & ctrl-q mappings
stty -ixon -ixoff

# Add dircolors
eval $(dircolors $DOTFILES/zsh/dircolors-solarized/dircolors.ansi-dark)

eval `keychain --eval --agents ssh --nogui -Q -q id_rsa`
