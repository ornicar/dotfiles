cd ~/
tmux start-server

if ! $(tmux has-session -t scratch); then

tmux set-option base-index 1
tmux new-session -d -s scratch -n scratch


  



tmux send-keys  -t scratch:1 '' C-m


tmux select-window -t scratch:1

fi

tmux -u attach-session -t scratch
