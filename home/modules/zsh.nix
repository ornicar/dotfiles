{ config, ... }: {
  programs.zsh = let

    constants = # sh
      ''

        # Load private configuration
        source ~/.zshrc.local
        # tells the cd command to look in this colon-separated list of directories for your destination.
        CDPATH=$HOME:..
        # https://github.com/zsh-users/zsh-autosuggestions?tab=readme-ov-file#suggestion-strategy
        ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      '';

    keychain = # sh
      ''

        # Unlock the ssh private key
        eval `keychain --eval --agents ssh --nogui -Q -q id_ed25519`
      '';

    fzfCompletion = # sh
      ''

        # https://github.com/junegunn/fzf?tab=readme-ov-file#settings
        FZF_COMPLETION_TRIGGER='..'

        # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
        _fzf_compgen_path() { fd --hidden --follow --exclude ".git" . "$1" }

        # Use fd to generate the list for directory completion
        _fzf_compgen_dir() { fd --type d --hidden --follow --exclude ".git" . "$1" }
      '';

    keyMappings = # sh
      ''

        # Avoid binding ^J, ^M,  ^C, ^?, ^S, ^Q, etc.
        bindkey -d # Reset to default.
        bindkey -v # Use vi key bindings.

        bindkey "^ " autosuggest-accept
        bindkey "^n" autosuggest-execute
        bindkey -M vicmd "e" history-search-backward
        bindkey -M vicmd "n" history-search-forward
        bindkey -M vicmd v edit-command-line # ESC-v to edit in an external editor.
        bindkey -M viins "^L" clear-screen
        bindkey -M viins "^W" backward-kill-word
      '';

    editCommandLine = # sh
      ''

        # Allow command line editing in an external editor.
        autoload -Uz edit-command-line
        zle -N edit-command-line
      '';

    zshCompletion = # sh
      ''

        # complete case insensitive (https://stackoverflow.com/questions/13424429/can-zsh-do-smartcase-completion-like-vims-search)
        zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

        # complete sudo commands
        zstyle ':completion::complete:*' gain-privileges 1

        bindkey '^E' fzf-history-widget # must be after compinit
      '';

    functions = # sh
      ''

        function limosh() { mosh root@$1.lichess.ovh }
        function psg() { ps aux | grep $* }
        function batf() { tail -F $1 | bat --paging=never --plain -l log }
        function take() { mkdir -p $1; cd $1 }
        # Get a 16 chars password: generate-password 16
        function generate-password() { strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $1 | tr -d '\n'; echo }
        function where-from() { readlink -f $(which $1) }
      '';
  in {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    history = {
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh_history";
      size = 100000;
      save = 100000;
    };
    initExtraBeforeCompInit = ''
      ${constants}
      ${fzfCompletion}
      ${keychain}
      ${editCommandLine}
      ${keyMappings}
      ${functions}
    '';
    initExtra = ''
      ${zshCompletion}
    '';
    shellAliases = let dotfiles = "${config.home.homeDirectory}/dotfiles";
    in {
      "nswitch" = "nh os switch ${dotfiles}";
      "ntry" = "nh os test ${dotfiles}";
      "ndry" = "nh os test ${dotfiles} --dry";
      "nup" = "nh os switch --update ${dotfiles}";
      "su" = "systemctl --user";
      "sr" = "sudo systemctl";
      "ju" = "journalctl --user -u";
      "jr" = "sudo journalctl -u ";
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
      # Stuff
      "st" = "systemctl-tui";
      "mongo-ssh" =
        "ssh -fNL 27117:rodan.vrack.lichess.ovh:27017 root@rodan.lichess.ovh";
      "mongo-ssh-pri" =
        "ssh -NL 27917:kaiju.vrack.lichess.ovh:27017 root@kaiju.lichess.ovh";
      "on" = ''swaymsg " output * power on"'';
    };
  };
}
