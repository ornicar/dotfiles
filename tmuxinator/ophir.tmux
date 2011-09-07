#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/ophir
tmux start-server

if ! $(tmux has-session -t 'ophir'); then

tmux new-session -d -s 'ophir' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'ophir':2 -n 'zsh'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'ophir':1 'vim' C-m


# tab "zsh"



tmux select-window -t 'ophir':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'ophir'
else
    tmux -u switch-client -t 'ophir'
fi
