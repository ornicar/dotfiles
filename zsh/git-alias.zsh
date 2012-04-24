#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
#
# There are some git alias that save my time

alias t='tig status'
alias g='git'
alias gs='git status'
alias ga='git add -A'
alias gf='git fetch'
alias gl='git pull'
alias glr='git pull --rebase'
alias gp='git push'
alias gpw='git-push-write'
alias gc='git commit -v'
alias gca='git commit --amend'
alias gch='git commit --amend -C HEAD'
alias gac='git commit -av'
alias gb='git branch -v'
alias gba='git branch -va'
alias gcp='git cherry-pick'
alias glo='git l'
alias gco='git checkout'
alias gm='git merge'
alias gmt='git mergetool'
alias gd='git diff'
alias gr='git remote -v'
alias gcf='git clean -f'
alias grh='git reset --hard'
alias grhh='git reset --hard HEAD'
alias gslr='git-stash-pull-rebase'
alias gslrp='git-stash-pull-rebase && git push'
alias gw='git wtf'

# Override aliases with functions
# to keep autocompletion
function gl(){git-up "$@"}
function glr(){git-up --rebase "$@"}
