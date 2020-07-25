#!/usr/bin/env zsh

alias t='tig status'
alias g='git'
alias gs='git status'
alias ga='git add -A'
alias gf='git fetch'
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
alias gmt='git mergetool --no-prompt'
alias gd='git diff'
alias gr='git remote -v'
alias gcf='git clean -f'
alias grh='git reset --hard'
alias grhh='git reset --hard HEAD'
alias gslr='git-stash-pull-rebase'
alias gslrp='git-stash-pull-rebase && git push'
alias gw='git wtf'

# Goes up the tree to the git root dir
alias g-='cd $(git rev-parse --show-toplevel || echo ".")'

# Override aliases with functions
# to keep autocompletion
function gl(){git-up "$@"}
function glr(){git-up --rebase "$@"}
