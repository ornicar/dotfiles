#!/bin/zsh

# Get a 7 chars password: generate-password 7
generate-password() {
  strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $1 | tr -d '\n'; echo
}

# Man inside vim
man() { vim -M -c "Man $*" -c "set nomodifiable" -c "only" }

# Calculator
calc() { awk "BEGIN{ print $* }" ;}

# works with both integers and floats
percent-spark() {
  if (( $1 < 10 )); then printf " "
  elif (( $1 < 20 )); then printf "⎯"
  elif (( $1 < 30 )); then printf "▁"
  elif (( $1 < 40 )); then printf "▂"
  elif (( $1 < 50 )); then printf "▃"
  elif (( $1 < 60 )); then printf "▄"
  elif (( $1 < 70 )); then printf "▅"
  elif (( $1 < 80 )); then printf "▆"
  elif (( $1 < 90 )); then printf "▇"
  else printf "█"
  fi
}
