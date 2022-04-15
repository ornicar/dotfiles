#!/bin/zsh

# Get a 7 chars password: generate-password 7
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
  git remote add $user git@github.com:/$user/$repo
  git fetch $user
  git checkout -b $user-$branch $user/$branch
  git merge master
}

# java paths are for local use only
# else use archlinux-java

# java8() {
#   export PATH="/usr/lib/jvm/java-8-openjdk/jre/bin/:$PATH"
#   java -version
# }
# java9() {
#   export PATH="/usr/lib/jvm/java-9-jdk/jre/bin/:$PATH"
#   java -version
# }
# java11() {
#   export PATH="/usr/lib/jvm/java-11-openjdk/bin/:$PATH"
#   java -version
# }
# java13() {
#   export PATH="/usr/lib/jvm/java-13-openjdk/bin/:$PATH"
#   java -version
# }
# grallvm11() {
#   export PATH="/usr/lib/jvm/java-11-grallvm/bin/:$PATH"
#   java -version
# }
