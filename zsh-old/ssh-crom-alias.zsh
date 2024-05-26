
sshcd () { ssh -t "$1" "cd \"$2\"; exec \$SHELL -l"; }
sshrun () { ssh "$1" "cd \"$2\"; \$3"; }
moshcd () { mosh -t "$1" "cd \"$2\"; exec \$SHELL -l"; }
moshrun () { mosh "$1" "cd \"$2\"; \$3"; }

alias cr='mosh crom'
alias crlila='moshcd crom ~/lila'
alias crlog='mosh crom "cd ~/lila; pnpm multilog"'
# alias crvim='mosh crom "cd ~/lila; nvim"'
alias crlistart='ssh crom "systemctl --user restart lila"'
