#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
#
# There are some zsh functions I find useful

# Get a 7 chars password: generate-password 7 
generate-password() {
    strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $1 | tr -d '\n'; echo
}

# Man inside vim
man() { vim -M -c "Man $*" -c "set nomodifiable" -c "only" }

# Calculator
calc(){ awk "BEGIN{ print $* }" ;}
