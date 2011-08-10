#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/sltc
tmux start-server

if ! $(tmux has-session -t 'sltc'); then

tmux new-session -d -s 'sltc' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'sltc':2 -n 'zsh'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'sltc':1 'vim' C-m


# tab "zsh"



tmux select-window -t 'sltc':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'sltc'
else
    tmux -u switch-client -t 'sltc'
fi
