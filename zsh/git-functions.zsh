#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
#
# There are some git function that save my time

# Get the current branch name if any
git-current-branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

# Push to a remote wich has no write url defined :)
git-push-write() {
    [ -z $1 ] && 1=origin
    git push $(git config --get "remote.$1.url"|sed 's#git://\([^/]*\)/\([^/]*\)/\(.*\)#git@\1:\2/\3#')
}

# Create a write remote from a readonly remote
git-create-write() {
    [ -z $1 ] && 1=origin
    remote="write-$1"
    git remote add $remote $(git config --get "remote.$1.url"|sed 's#git://\([^/]*\)/\([^/]*\)/\(.*\)#git@\1:\2/\3#')
    git remote -v
    git fetch $remote
    git-set-upstream $1
}

# Set the upstream branch
git-set-upstream() {
    [ -z $1 ] && 1=origin
    branch=$(git-current-branch)
    git branch --set-upstream $branch $1/$branch
}
