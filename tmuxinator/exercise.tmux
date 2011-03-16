#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/exercise
tmux start-server

if ! $(tmux has-session -t 'exercise'); then

tmux new-session -d -s 'exercise' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'exercise':2 -n 'exercise'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'exercise':1 'vim' C-m


# tab "exercise"

tmux send-keys -t 'exercise':2 'tig' C-m



tmux select-window -t 'exercise':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'exercise'
else
    tmux -u switch-client -t 'exercise'
fi
