# Go back 3 times
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Propagate user config
alias _='sudo -E'

# A better ls https://the.exa.website/
alias ls='exa'

# List directory contents
alias l='ls -la'

# Sort dirs by weight
alias ducks='du -lcks * | sort -rn|head -20'

# History alias
alias h='history'

# Add suffix alias for less
alias -g L='| less'

# Vim
alias v="nvim"

# Lila
alias li="./lila"

# Extract anything
alias x="dtrx"

# Resource this file
alias reload=". ~/.zshrc"

alias meteo="curl -4 http://wttr.in/Paris"

# Read 32GB zero's and throw them away.
alias benchmark='\dd if=/dev/zero of=/dev/null bs=1M count=32768'

# Soooo lazy
alias ya='yay'

alias halt="echo 'Use poweroff instead'"

# alias wifi='nmcli -f name,ssid,bssid,chan,rate,signal,bars,security,device,active,in-use dev wifi'
alias wifi='iwctl station wlan0 scan; iwctl station wlan0 get-networks; iwctl station wlan0 show'

alias lipass="PASSWORD_STORE_DIR=~/lichess-sysadmin/pass pass"
