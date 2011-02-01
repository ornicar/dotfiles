#!/bin/zsh

# Show a gentle cow
fortune | cowsay

export PATH="$PATH:~/.bin"
export BROWSER="chromium-browser"
export EDITOR='vim'
export GIT_EDITOR='vim -X'

# Configure oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="ornicar"
export DISABLE_AUTO_UPDATE="true"

# Run oh-my-zsh
plugins=(git vi-mode)
source $ZSH/oh-my-zsh.sh

# Go back 3 times
alias ....='cd ../../..'

# Sort dirs by weight
alias ducks='du -cks * | sort -rn|head -10'

# History alias
alias h='history'

# Vim
alias v="vim"

# Git
alias t='tig status'
alias s='git status'
alias glr='git pull --rebase'
alias gco='git checkout'
alias gmt='git mergetool'
alias gca='git commit --amend'

# Ctags
alias ct="rm tags && ctags -h '.php' --PHP-kinds=+cf --recurse --exclude='*/cache/*' --exclude='*/logs/*' --exclude='*/data/*' --exclude='\.git' --exclude='\.svn' --languages=PHP &"

# PHPUnit
alias phpunituntil="phpunit --stop-on-failure --stop-on-error"

# Resource this file
alias reload=". ~/.zshrc"

# Start web server
alias startwebserver="sudo /etc/rc.d/nginx start && sudo /etc/rc.d/php-fpm start && sudo /etc/rc.d/mongodb start && sudo /etc/rc.d/memcached start"

# Restart web server
alias restartwebserver="sudo /etc/rc.d/nginx restart && sudo /etc/rc.d/php-fpm restart && sudo /etc/rc.d/mongodb restart"

# Man inside vim
man() { vim -X -M -c "Man $*" -c "only" }

# Calculator
calc(){ awk "BEGIN{ print $* }" ;}

# Python2
alias p="python2"

# Switch to exercise.com hardware
exercisehardware() {
    xrandr --output HDMI1 --off --output LVDS1 --mode 1366x768 --pos 272x1080 --rotate normal --output DP1 --off --output VGA1 --mode 1920x1080 --pos 0x0 --rotate normal
}

# Increase urxvt font size
alias bigger="printf '\33]50;%s\007' \"xft:Inconsolata:size=19\""

# Launch music player daemon and client
music() {
    [ ! -f ~/.mpd/mpd.pid ] && mpd ~/.mpd/mpd.conf
    ncmpcpp
}

# radios are in ~/data/radio
alias radio="mplayer -playlist"

# Byobu presets
alias blichess="cd ~/data/workspace/lichess && BYOBU_WINDOWS='li' byobu -S lichess"
alias bexercise="cd ~/data/workspace/exercise && BYOBU_WINDOWS='ex' byobu -S exercise"
alias bsystem="cd ~/data/workspace/dotfiles && BYOBU_WINDOWS='sy' byobu -S system"
alias bim="BYOBU_WINDOWS='im' byobu -S im"
alias bmedia="cd ~/data && BYOBU_WINDOWS='me' byobu -S media"

# Use google for translation
alias trans="python2 ~/.scripts/translate"
alias enfr="python2 ~/.scripts/translate -s en -d fr"
alias fren="python2 ~/.scripts/translate -s fr -d en"

# Search using surfraw
alias gg="surfraw google"
alias dd="surfraw duckduckgo"
alias search-urban="surfraw urban"
alias search-acronym="surfraw acronym"

# Connect using 3G usb dialer, and notify when connection is lost
alias dial='sudo wvdial && notify-send "wvdial" "Connection lost"'

# use google for a definition 
define() {
  local lang charset tmp

  lang="${LANG%%_*}"
  charset="${LANG##*.}"
  tmp='/tmp/define'
  
  lynx -accept_all_cookies \
       -dump \
       -hiddenlinks=ignore \
       -nonumbers \
       -assume_charset="$charset" \
       -display_charset="$charset" \
       "http://www.google.com/search?hl=$lang&q=define%3A+$1&btnG=Google+Search" | grep -m 5 -C 2 -A 5 -w "*" > "$tmp"

  if [[ ! -s "$tmp" ]]; then
    echo -e "No definition found.\n"
  else
    echo -e "$(grep -v Search "$tmp" | sed "s/$1/\\\e[1;32m&\\\e[0m/g")\n"
  fi

  rm -f "$tmp"
}
