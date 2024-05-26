#!/usr/bin/env zsh

# stash and pull rebase, then stash pop if stashed
git-stash-pull-rebase() {
    stashresult=$(git stash)
    echo $stashresult
    git pull --rebase
    if [ $stashresult != "No local changes to save" ]; then
        git stash pop
    fi
}

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
    git push $1 $branch --set-upstream
}

# revert in working tree only
# https://stackoverflow.com/a/33676571
git-revert() {
  git show $1 | git apply -R
}

gmm() {
  git merge master --no-edit
}
