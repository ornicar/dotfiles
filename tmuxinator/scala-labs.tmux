#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/scala-labs/labs
tmux start-server

if ! $(tmux has-session -t 'scala-labs'); then

tmux new-session -d -s 'scala-labs' -n 'vim'
tmux set-option base-index 1


tmux new-window -t 'scala-labs':2 -n 'zsh'


# set up tabs and panes

# tab "vim"

tmux send-keys -t 'scala-labs':1 'vim' C-m


# tab "zsh"



tmux select-window -t 'scala-labs':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'scala-labs'
else
    tmux -u switch-client -t 'scala-labs'
fi
