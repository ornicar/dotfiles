
sshcd () { ssh -t "$1" "cd \"$2\"; exec \$SHELL -l"; }
sshrun () { ssh "$1" "cd \"$2\"; \$3"; }

alias cr='ssh crom'
alias crlila='sshcd crom ~/lila'
alias crlog='ssh crom "cd ~/lila; pnpm multilog"'
alias crvim='ssh crom "cd ~/lila; nvim"'
alias crlistart='ssh crom "systemctl --user restart lila'
