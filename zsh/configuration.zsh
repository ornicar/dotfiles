#!/usr/bin/env zsh
#
# Exports and oh-my-zsh configuration

# Export common variables
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$DOTFILES/scripts:$PATH"
export PATH="$HOME/.gem/ruby/2.1.0/bin:$PATH"
export PATH="$HOME/git-hub:$PATH"
export PATH="$HOME/android-sdk/android-sdk-linux/tools/:$PATH"
export PATH="$HOME/android-sdk/android-sdk-linux/platform-tools/:$PATH"

export TERMINAL="urxvtc"
export BROWSER="chromium"
export EDITOR='vim'
export GIT_EDITOR='vim'

# Java/SBT configuration
export SBT_OPTS="-Xms64M -Xmx2048M -Xss4M -XX:ReservedCodeCacheSize=64m -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC"
# export SBT_OPTS="-Xms64M -Xmx512M -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC"

# oh-my-zsh configuration
export DISABLE_AUTO_TITLE="true"

# clojurescript
export CLOJURESCRIPT_HOME="$HOME/clojurescript"
export PATH="$CLOJURESCRIPT_HOME/bin:$PATH"

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
