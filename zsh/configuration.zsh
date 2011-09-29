#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
#
# Exports and oh-my-zsh configuration

# Export common variables
export PATH="$PATH:$HOME/bin:$DOTFILES/scripts:$HOME/.cabal/bin"
export BROWSER="browser"
export EDITOR='vim'
export GIT_EDITOR='vim'

# Java/SBT configuration
export SBT_OPTS="-Dfile.encoding=UTF8 -Xms388M -Xmx939M -Xss2M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=512m"
#export SBT_OPTS = "-Dfile.encoding=UTF8 -Xms128M -Xmx1526M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=512m"

# Fix ttytter
export PERL_SIGNALS=unsafe

# oh-my-zsh configuration
export DISABLE_AUTO_TITLE="true"

# Enable more syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets)

# CDPATH tells the cd command to look in
# this colon-separated list of directories for your destination.
CDPATH=:..:~/data:~/data/workspace

# Load less keys
lesskey "$DOTFILES/lesskeys"

# Disable flow control in rxvt, frees ctrl-s & ctrl-q mappings
stty -ixon -ixoff
