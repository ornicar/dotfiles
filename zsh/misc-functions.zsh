#!/usr/bin/env zsh

# Get a 7 chars password: generate-password 7 
generate-password() {
    strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $1 | tr -d '\n'; echo
}

# Man inside vim
man() { vim -M -c "Man $*" -c "set nomodifiable" -c "only" }

# Calculator
calc(){ awk "BEGIN{ print $* }" ;}
