_TMUX=$TMUX
TMUX=
cd ~/data/workspace/dotfiles
tmux start-server

if ! $(tmux has-session -t system); then

tmux set-option base-index 1
tmux new-session -d -s system -n zsh


  



tmux send-keys  -t system:1 '' C-m


tmux select-window -t system:1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t system
else
    tmux -u switch-client -t system
fi
