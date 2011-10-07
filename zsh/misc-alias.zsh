# Go back 3 times
alias ....='cd ../../..'

# Sort dirs by weight
alias ducks='du -cks * | sort -rn|head -10'

# History alias
alias h='history'

# Run tmuxinator
alias tmuxinator="$HOME/data/workspace/tmuxinator/bin/tmuxinator"

# Add suffix alias for less
alias -g L='| less'

# Vim
alias v="vim"

# PHPUnit
alias phpunituntil="phpunit --stop-on-failure --stop-on-error"

# Resource this file
alias reload=". ~/.zshrc"

# Start web server
alias startwebserver="sudo /etc/rc.d/nginx start && sudo /etc/rc.d/php-fpm start && sudo /etc/rc.d/mongodb start && sudo /etc/rc.d/elasticsearch start"
# Stop web server
alias stopwebserver="sudo /etc/rc.d/nginx stop && sudo /etc/rc.d/php-fpm stop && sudo /etc/rc.d/mongodb stop && sudo /etc/rc.d/elasticsearch stop"
# Restart web server
alias restartwebserver="sudo /etc/rc.d/nginx restart && sudo /etc/rc.d/php-fpm restart && sudo /etc/rc.d/mongodb restart"

# Run IM program
alias im="weechat-curses"

# Increase urxvt font size
alias bigger="printf '\33]50;%s\007' \"xft:Inconsolata:size=16\""

# radios are in ~/data/radio
alias radio="mplayer -playlist"

# Use google for translation
alias trans="python2 ~/.scripts/translate"
alias enfr="python2 ~/.scripts/translate -s en -d fr"
alias fren="python2 ~/.scripts/translate -s fr -d en"

# Search using surfraw
alias gg="surfraw google"
alias dd="surfraw duckduckgo"
alias search-urban="surfraw urban"
alias search-acronym="surfraw acronym"

# Read 32GB zero's and throw them away.
alias benchmark='\dd if=/dev/zero of=/dev/null bs=1M count=32768'

# Connect using 3G usb dialer
alias dial='sudo wvdial'

# Soooo lazy
alias ya='yaourt'

# Generate haskell tags
alias htags='find ./ -name "*.*hs" | xargs hasktags'
