_TMUX=$TMUX
TMUX=
cd ~/data/workspace
tmux start-server

if ! $(tmux has-session -t extra); then

tmux set-option base-index 1
tmux new-session -d -s extra -n workspace


  



tmux send-keys  -t extra:1 '' C-m


tmux select-window -t extra:1

fi

if [ -z $_TMUX ]; then
    tmux -u attach-session -t extra
else
    tmux -u switch-client -t extra
fi
