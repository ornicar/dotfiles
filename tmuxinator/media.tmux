cd ~/data
tmux start-server

if ! $(tmux has-session -t media); then

tmux set-option base-index 1
tmux new-session -d -s media -n irc


  

  
tmux new-window -t media:2 -n mail
  

  
tmux new-window -t media:3 -n music
  



tmux send-keys  -t media:1 'weechat-curses' C-m

tmux send-keys  -t media:2 'mutt' C-m

tmux send-keys  -t media:3 '' C-m


tmux select-window -t media:1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t media
else
    tmux -u switch-client -t media
fi
