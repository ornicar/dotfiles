#!/usr/bin/env zsh

# only init if installed.
fasd_cache="$HOME/.cache/fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# jump to recently used items
alias c='fasd_cd -d' # cd, same functionality as j in autojump
alias cc='fasd_cd -d -i' # interactive directory jump
alias v='f -e vim'
