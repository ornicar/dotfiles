#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/aichallenge
tmux start-server

if ! $(tmux has-session -t 'aichallenge'); then

tmux new-session -d -s 'aichallenge' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'aichallenge':2 -n 'zsh'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'aichallenge':1 'vim' C-m


# tab "zsh"



tmux select-window -t 'aichallenge':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'aichallenge'
else
    tmux -u switch-client -t 'aichallenge'
fi
