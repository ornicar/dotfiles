export EDITOR='vim'
export GIT_EDITOR='vim'

# Use vi mode when typing bash commands
set -o vi

# Show a gentle cow
fortune | cowsay

# Reload this file
alias so=". ~/.bashrc"

# ls aliases
alias ll='ls -hl --color=always'
alias la='ls -A'
alias l='ls -CF'

# Moving around
alias ..='cd ..'
alias ...='cd .. ; cd ..'
alias ....='cd .. ; cd .. ; cd ..'

# Show current dir basename
alias pwdn="basename `pwd`"

# Ignores dupes in the history
export HISTCONTROL=ignoredups
export HISTIGNORE="ls:cd:[bf]g:exit:..:...:ll"
alias h='history'

# After each command, checks the windows size and changes lines and columns
shopt -s checkwinsize

# Bash completion settings (actually, these are readline settings)
bind "set completion-ignore-case on"
bind "set bell-style none"
bind "set show-all-if-ambiguous On"

# Lists the size of all the folders and files
alias ducks='du -cms * | sort -rn|head -10'

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

# Git completion
source ~/.scripts/git/completion
#Git branch in the prompt
PS1='\W$(__git_ps1 " (%s)")\$ '

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

# Tar aliases
alias untar="tar xvzf"

# Vim aliases
alias v='vim'
# Run vim in a new terminator instance
alias vv="terminator --execute 'vim' 2> /dev/null &"

# Resource this file
alias ba="source ~/.bashrc"

# Search
if type -P ack-grep &>/dev/null ; then # Use ack for grepping and find if ack is available
  ack(){
    ack-grep "$*" --color-match=green --color-filename=blue --smart-case
  }
  ackw(){
    ack-grep "$*" --color-match=green --color-filename=blue --word-regexp --smart-case
  }
fi

# Bookmark dirs
if [ ! -f ~/.dirs ]; then  # if doesn't exist, create it
    touch ~/.dirs
fi
alias show='cat ~/.dirs'
save (){
    command sed "/!$/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs ;
}
source ~/.dirs  # Initialization for the above 'save' facility: source the .sdirs file
shopt -s cdable_vars # set the bash option so that no '$' is required when using the above facility

# Local config
if [ -f ~/.bashrc_local ]; then
	source ~/.bashrc_local
fi
