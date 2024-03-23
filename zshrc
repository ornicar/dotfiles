#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# export THEFUCK_PRIORITY="git_hook_bypass=1100" # https://github.com/nvbn/thefuck/issues/1207
# eval $(thefuck --alias)

# Load all of my zsh files in zsh/
for zsh_file (~/dotfiles/zsh/*.zsh) source $zsh_file

# Uncomment when fzf 0.48 lands in nix
# eval "$(fzf --zsh)"
source ~/tmp/fzf.zsh

# Load private configuration
source ~/.zshrc.local

#source /run/current-system/sw/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /run/current-system/sw/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/dotfiles/p10k.zsh ]] || source ~/dotfiles/p10k.zsh

# source /usr/share/nvm/init-nvm.sh
#
# # Ctrl+e = Ctrl+r. Must be after ~/.fzf.zsh, which seems to need to be near the end :-/
bindkey '^E' fzf-history-widget
