#!/bin/zsh

# Show a gentle cow
fortune | cowsay

export PATH="$PATH:/home/thib/.bin"
export BROWSER="chromium-browser"
export EDITOR='vim'
export GIT_EDITOR='vim'

# Configure oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="ornicar"
export DISABLE_AUTO_UPDATE="true"

# Run oh-my-zsh
plugins=(vi-mode)
source $ZSH/oh-my-zsh.sh

# CDPATH tells the cd command to look in this colon-separated list of directories for your destination.
CDPATH=:..:~/data:~/data/workspace:/etc

# Go back 3 times
alias ....='cd ../../..'

# Sort dirs by weight
alias ducks='du -cks * | sort -rn|head -10'

# History alias
alias h='history'

# Run tmuxinator
alias tmuxinator="$HOME/data/workspace/tmuxinator/bin/tmuxinator"

# Vim
alias v="vim"

# Git
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
alias gb='git branch'
alias gba='git branch -a'
alias gcp='git cherry-pick'
alias glo='git log'
alias glg='git log --stat --max-count=20'
alias glp='git log -p'
alias gco='git checkout'
alias gm='git merge'
alias gmt='git mergetool'
alias gd='git diff'
alias gr='git remote -v'
alias gcf='git clean -f'
alias gh='hub'

# Add suffix alias for less
alias -g L='| less'

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

# Ctags
alias ct="touch tags && rm tags && ctags -h '.php' --tag-relative=yes --PHP-kinds=+cf --fields=+afkst --recurse --exclude='*/cache/*' --exclude='*/logs/*' --exclude='*/data/*' --exclude='\.git' --exclude='\.svn' --exclude='*/swiftmailer/*' --exclude='*/zend/*' --exclude='*/bootstrap.*' --languages=PHP --regex-PHP=\"/@method[ ][^ ]+[ ]+([^ (]*)/\1/f/\" &"

# PHPUnit
alias phpunituntil="phpunit --stop-on-failure --stop-on-error"

# Resource this file
alias reload=". ~/.zshrc"

# Restart web server
alias restartwebserver="sudo /etc/rc.d/nginx restart && sudo /etc/rc.d/php-fpm restart && sudo /etc/rc.d/mongodb restart"

# Run IM program
alias im="weechat-curses"

# Man inside vim
man() { vim -X -M -c "Man $*" -c "set nomodifiable" -c "only" }

# Calculator
calc(){ awk "BEGIN{ print $* }" ;}

# Increase urxvt font size
alias bigger="printf '\33]50;%s\007' \"xft:Inconsolata:size=16\""

# radios are in ~/data/radio
alias radio="mplayer -playlist"

# Use google for translation
alias trans="python2 ~/.scripts/translate"
alias enfr="python2 ~/.scripts/translate -s en -d fr"
alias fren="python2 ~/.scripts/translate -s fr -d en"

# Search using surfraw
alias gg="surfraw google"
alias dd="surfraw duckduckgo"
alias search-urban="surfraw urban"
alias search-acronym="surfraw acronym"

# Get a 7 chars password: generate-password 7 
generate-password() {
    strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $1 | tr -d '\n'; echo
}

# Read 32GB zero's and throw them away.
alias benchmark='\dd if=/dev/zero of=/dev/null bs=1M count=32768'

# Connect using 3G usb dialer
alias dial='sudo wvdial'

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

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
