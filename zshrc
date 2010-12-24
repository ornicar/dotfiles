# Path to oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="robbyrussell"

# oh-my-zsh plugins
plugins=(git)

# Launch oh-my-zsh
source $ZSH/oh-my-zsh.sh

export EDITOR='vim'
export GIT_EDITOR='vim'

# Show a gentle cow
fortune | cowsay

# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
HISTCONTROL=ignoredups
HISTIGNORE="ls:cd:[bf]g:exit:..:...:ll"

# ls aliases
alias ll='ls -hl --color=always'
alias la='ls -A'
alias l='ls -CF'

# Moving around
alias ..='cd ..'
alias ...='cd .. ; cd ..'
alias ....='cd .. ; cd .. ; cd ..'

# History alias
alias h='history'

# Lists the size of all the folders and files
alias ducks='du -cks * | sort -rn|head -10'

alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"
 
#Git aliases
alias s='git status'
alias t='tig'
alias c="git commit"
alias cm="git commit -m"
alias ca="git commit --amend"
alias co="git checkout"
alias c-="git checkout -- ."
alias pu="git pull"
alias pur="git pull --rebase"

# Byobu presets
alias blichess="echo 'cd src/Bundle/LichessBundle && git status && bash' > /tmp/livendor \
&& cd ~/data/workspace/lichess \
&& BYOBU_WINDOWS='li' byobu -S lichess"
alias bexercise="cd ~/data/workspace/exercise && BYOBU_WINDOWS='ex' byobu -S exercise"
alias bdotfiles="cd ~/data/workspace/dotfiles && BYOBU_WINDOWS='do' byobu -S dotfiles"
alias bim="BYOBU_WINDOWS='im' byobu -S im"
alias bmedia="cd ~/data && BYOBU_WINDOWS='me' byobu -S media"

# Ctags
alias ct="rm tags && ctags-exuberant -h '.php' --PHP-kinds=+cf --recurse --exclude=*/cache/* --exclude=*/logs/* --exclude=*/data/* --exclude='\.git' --exclude='\.svn' --languages=PHP &"

# PHPUnit
alias phpunituntil="phpunit --stop-on-failure --stop-on-error"

# Clear the swap
alias swap='sudo swapoff -a && sudo swapon -a'

# Upgrade with APT
alias apt-hop='sudo apt-get update && sudo apt-get upgrade'

# Vim aliases
alias v='vim'

# Resource this file
alias reload=". ~/.zshrc"

# Man inside vim
man() { vim -X -R -c "Man $*" -c "only" -c "set nomodifiable" }

# Search
if type -P ack-grep &>/dev/null ; then # Use ack for grepping and find if ack is available
  ack(){
    ack-grep "$*" --color-match=green --color-filename=blue --smart-case
  }
  ackw(){
    ack-grep "$*" --color-match=green --color-filename=blue --word-regexp --smart-case
  }
fi
