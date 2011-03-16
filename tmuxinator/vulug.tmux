#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/vulug
tmux start-server

if ! $(tmux has-session -t 'vulug'); then

tmux new-session -d -s 'vulug' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'vulug':2 -n 'vulug'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'vulug':1 'vim' C-m


# tab "vulug"



tmux select-window -t 'vulug':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'vulug'
else
    tmux -u switch-client -t 'vulug'
fi
