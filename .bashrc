export EDITOR='vim'

# Use vi mode when typing bash commands
set -o vi

# ls aliases
alias ll='ls -hl --color=always'
alias la='ls -A'
alias l='ls -CF'

# Moving around
alias ..='cd ..'
alias ...='cd .. ; cd ..'

# Ignores dupes in the history
export HISTCONTROL=ignoredups

# After each command, checks the windows size and changes lines and columns
shopt -s checkwinsize

# Bash completion settings (actually, these are readline settings)
bind "set completion-ignore-case on"
bind "set bell-style none"
bind "set show-all-if-ambiguous On"

# Lists the size of all the folders and files
alias ducks='du -cksh * | sort -rn|head -10'

alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"
 
#Git shortcuts
alias g="git" # so lazy
alias s='git status'
alias d='git diff'
alias c="git commit"
alias cm="git commit -m"
alias a="git add -Av"
alias p="git add -p"
alias co="git checkout"

# Git submodule shortcuts
alias subupdate='git submodule sync && git submodule update --init --recursive'
alias subcheckout='git submodule foreach git checkout master'
alias subreset='git submodule foreach git checkout -- . && git submodule foreach git clean -f'
alias subpull='git submodule foreach git pull'

# Git completion
source ~/.git-completion.sh
#Git branch in the prompt
PS1='\W$(__git_ps1 " (%s)")\$ '

# PHPUnit
alias phpunituntil="phpunit --stop-on-failure --stop-on-error"

# Bookmark dirs
if [ ! -f ~/.dirs ]; then  # if doesn't exist, create it
    touch ~/.dirs
fi
alias show='cat ~/.dirs'
save (){
    command sed "/!$/d" ~/.dirss > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs ; 
}
source ~/.dirs  # Initialization for the above 'save' facility: source the .sdirs file
shopt -s cdable_vars # set the bash option so that no '$' is required when using the above facility

# Clear the swap
alias swap='sudo swapoff -a && sudo swapon -a'

# Upgrade with APT
alias apt-hop='sudo apt-get update && sudo apt-get upgrade'
