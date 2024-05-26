{ pkgs, config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    # defaultKeymap = "vicmd";
    initExtra = ''
# Load private configuration
source ~/.zshrc.local

# tells the cd command to look in
# this colon-separated list of directories for your destination.
CDPATH=$HOME:..

eval `keychain --eval --agents ssh --nogui -Q -q id_ed25519`

# Vimify

# Allow command line editing in an external editor.
autoload -Uz edit-command-line

# This comes from the vi-mode plugin
function zle-line-init {
  zle reset-prompt
}

zle -N zle-line-init
zle -N edit-command-line

# Avoid binding ^J, ^M,  ^C, ^?, ^S, ^Q, etc.
bindkey -d # Reset to default.
bindkey -v # Use vi key bindings.
bindkey -M vicmd v edit-command-line # ESC-v to edit in an external editor.

# Vi mappings adapted to colemak layout
bindkey ' ' magic-space 
bindkey -M vicmd "gg" beginning-of-history
bindkey -M vicmd "G" end-of-history
bindkey -M vicmd "e" history-search-backward
bindkey -M vicmd "n" history-search-forward
bindkey -M vicmd "?" history-incremental-search-backward
bindkey -M vicmd "/" history-incremental-search-forward
bindkey -M viins "^L" clear-screen
bindkey -M viins "^W" backward-kill-word
bindkey -M viins "^A" beginning-of-line
bindkey -M viins "^E" end-of-line

# Functions

limosh() { mosh root@$1.lichess.ovh }
psg() { ps aux | grep $* }
batf() { tail -F $1 | bat --paging=never --plain -l log }
take() {
  mkdir -p $1
  cd $1
}
# Get a 16 chars password: generate-password 16
generate-password() {
  strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $1 | tr -d '\n'; echo
}

# FZF
eval "$(fzf --zsh)"

# Ctrl+e = Ctrl+r. Must be after ~/.fzf.zsh, which seems to need to be near the end :-/
bindkey '^E' fzf-history-widget
'';
    shellAliases = 
      let 
        xdgDir = "${config.home.homeDirectory}/.config";
        nixDir = "${config.home.homeDirectory}/nixos-config";
      in {
      "nswitch"="nh os switch ~/nixos-config/";
      "ntry"="nh os test ~/nixos-config/ --verbose";
      "nup"="nh os switch --update ~/nixos-config/";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
# Propagate user config
      "_" = "sudo -E";
      "l" = "ls -la";
      "h" = "history";
# Add suffix alias for less
      "-g L" = "| less";
      "v" = "nvim";
      "x" = "dtrx";
      "reload" = ". ~/.zshrc";
      "meteo" = "curl -4 http://wttr.in/44600";
      "lipass" = "PASSWORD_STORE_DIR=~/lichess-sysadmin/pass pass";
# Nix
# https://nixos-and-flakes.thiscute.world/best-practices/accelerating-dotfiles-debugging
      "nvim-clean" = "rm -rf ${xdgDir}/nvim/lua";
      "nvim-test" = "nvim-clean && rsync -avz --copy-links --chmod=D2755,F744 ${nixDir}/home/modules/neovim/nvim/lua ${xdgDir}/nvim/";
# Git aliases
      "t" = "lazygit";
      "g" = "git";
      "gs" = "git status";
      "ga" = "git add -A";
      "gf" = "git fetch";
      "gp" = "git push";
      "gl" = "git pull";
      "glr" = "git pull --rebase";
      "gpw" = "git-push-write";
      "gc" = "git commit -v";
      "gca" = "git commit --amend";
      "gch" = "git commit --amend -C HEAD";
      "gac" = "git commit -av";
      "gb" = "git branch -v";
      "gba" = "git branch -va";
      "gcp" = "git cherry-pick";
      "glo" = "git l";
      "gco" = "git checkout";
      "gm" = "git merge";
      "gmt" = "git mergetool --no-prompt";
      "gd" = "git diff";
      "gr" = "git remote -v";
      "gcf" = "git clean -f";
      "grh" = "git reset --hard";
      "grhh" = "git reset --hard HEAD";
      "gslr" = "git-stash-pull-rebase";
      "gslrp" = "git-stash-pull-rebase && git push";
      "gw" = "git wtf";
    };
    history = {
      size = 100000;
      save = 100000;
    };
  };
}
