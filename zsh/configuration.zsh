#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
#
# Exports and oh-my-zsh configuration

# Export common variables
export PATH="$PATH:$HOME/.bin"
export BROWSER="chromium-browser"
export EDITOR='vim'
export GIT_EDITOR='vim'

# CDPATH tells the cd command to look in
# this colon-separated list of directories for your destination.
CDPATH=:..:~/data:~/data/workspace:/etc
