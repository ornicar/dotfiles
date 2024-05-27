{ pkgs, config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh_history";
      size = 100000;
      save = 100000;
    };
    initExtra = ''
# Load private configuration
source ~/.zshrc.local

# https://github.com/zsh-users/zsh-autosuggestions?tab=readme-ov-file#suggestion-strategy
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# tells the cd command to look in
# this colon-separated list of directories for your destination.
CDPATH=$HOME:..

eval `keychain --eval --agents ssh --nogui -Q -q id_ed25519`

# Vimify

# Allow command line editing in an external editor.
autoload -Uz edit-command-line

zle -N edit-command-line

# Avoid binding ^J, ^M,  ^C, ^?, ^S, ^Q, etc.
bindkey -d # Reset to default.
bindkey -v # Use vi key bindings.
bindkey -M vicmd v edit-command-line # ESC-v to edit in an external editor.

bindkey "^ " autosuggest-accept

# Vi mappings adapted to colemak layout
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

# Ctrl+e = Ctrl+r
bindkey '^E' fzf-history-widget
'';
    shellAliases = 
      let 
        xdgDir = config.xdg.configHome;
        nixDir = "${config.home.homeDirectory}/dotfiles";
      in {
      "nswitch"="nh os switch ${nixDir}";
      "ntry"="nh os test ${nixDir}";
      "nup"="nh os switch --update ${nixDir}";
      "su"= "systemctl --user";
      "sr"= "sudo systemctl";
      "ju"= "journalctl --user";
      "jr"= "sudo systemctl";
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
  };
}
