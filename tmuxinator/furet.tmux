#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/furet
tmux start-server

if ! $(tmux has-session -t 'furet'); then

tmux new-session -d -s 'furet' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'furet':2 -n 'git'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'furet':1 'vim' C-m


# tab "git"



tmux select-window -t 'furet':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'furet'
else
    tmux -u switch-client -t 'furet'
fi
