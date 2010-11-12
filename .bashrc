# ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias swap='sudo swapoff -a && sudo swapon -a'
alias apt-hop='sudo apt-get update && sudo apt-get upgrade'
alias s='git status'
alias d='git diff'
alias subupdate='git submodule sync && git submodule update --init --recursive'
alias subcheckout='git submodule foreach git checkout master'
alias subreset='git submodule foreach git checkout -- . && git submodule foreach git clean -f'
alias subpull='git submodule foreach git pull'
alias c="git commit"
alias a="git add -Av"
alias p="git add -p"
alias phpunituntil="phpunit --stop-on-failure --stop-on-error"
alias jackrabbit="java -jar /home/thib/data/bin/jackrabbit-standalone-*.jar"

# git goodness
source ~/.git-completion.sh
PS1='\W$(__git_ps1 " (%s)")\$ '

# tip of the year
set -o vi
