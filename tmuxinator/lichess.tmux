#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/lichess
tmux start-server

if ! $(tmux has-session -t 'lichess'); then

tmux new-session -d -s 'lichess' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'lichess':2 -n 'lichess'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'lichess':1 'vim' C-m


# tab "lichess"

tmux send-keys -t 'lichess':2 'tig' C-m



tmux select-window -t 'lichess':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'lichess'
else
    tmux -u switch-client -t 'lichess'
fi
