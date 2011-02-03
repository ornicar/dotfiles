cd ~/data/workspace/vulug
tmux start-server

if ! $(tmux has-session -t vulug); then

tmux set-option base-index 1
tmux new-session -d -s vulug -n vim


  

  
tmux new-window -t vulug:2 -n vulug
  



tmux send-keys  -t vulug:1 'vim' C-m

tmux send-keys  -t vulug:2 '' C-m


tmux select-window -t vulug:1

fi

tmux -u attach-session -t vulug
