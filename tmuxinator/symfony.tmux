#!/bin/zsh
_TMUX=$TMUX
TMUX=
cd ~/data/workspace/symfony
tmux start-server

if ! $(tmux has-session -t 'symfony'); then

tmux new-session -d -s 'symfony' -n 'vim'
tmux set-option base-index 1



# set up tabs and panes

# tab "vim"

tmux send-keys -t 'symfony':1 'vim' C-m



tmux select-window -t 'symfony':1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t 'symfony'
else
    tmux -u switch-client -t 'symfony'
fi
