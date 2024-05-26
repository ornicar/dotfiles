#!/bin/zsh

# Get a 16 chars password: generate-password 16
generate-password() {
  strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $1 | tr -d '\n'; echo
}

# Man inside vim
# man() { vim -M -c "Man $*" -c "set nomodifiable" -c "only" }

# Calculator
calc() { awk "BEGIN{ print $* }" ;}

psg() { ps aux | grep $* }

batf() { tail -F $1 | bat --paging=never --plain -l log }

limosh() { mosh root@$1.lichess.ovh }
lissh() { ssh root@$1.lichess.ovh }

function andagain { while : ; do "$@" ; sleep 1 ; done; }

take() {
  mkdir -p $1
  cd $1
}

# github-pr-checkout ryantmurray10:touchpad-delta
github-pr-checkout() {
  parts=("${(@s/:/)1}")
  user=$parts[1]
  branch=$parts[2]
  repo=${PWD##*/}
  remote=https://github.com/$user/$repo.git
  echo $remote
  git remote add $user $remote
  git fetch $user
  git branch -D $user-$branch
  git checkout -b $user-$branch $user/$branch
  git merge master
}
