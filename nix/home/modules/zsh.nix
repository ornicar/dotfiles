{ config, ... }: {
  programs.zsh = let

    stty = # sh
      ''
        # unbind ^S, ^Q
        # https://unix.stackexchange.com/questions/12107/how-to-unfreeze-after-accidentally-pressing-ctrl-s-in-a-terminal
        stty -ixon
      '';

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

        bindkey "^H" autosuggest-execute
        bindkey "^ " autosuggest-accept
        bindkey "^Q" autosuggest-clear
        bindkey -M vicmd "e" history-search-backward
        bindkey -M vicmd "n" history-search-forward
        bindkey -M vicmd "^[[A" history-search-backward # up
        bindkey -M vicmd "^[[B" history-search-forward # down
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

        bindkey "''${key[Up]}" fzf-history-widget
      '';

    functions = # sh
      ''

        function limosh() { mosh root@$1.lichess.ovh }
        function psg() { ps aux | grep $* }
        function take() { mkdir -p $1; cd $1 }
        # Get a 16 chars password: generate-password 16
        function generate-password() { strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $1 | tr -d '\n'; echo }
        function where-from() { readlink -f $(which $1) }
        function url-sha256() { curl -sL $1 | sha256sum | cut -d ' ' -f 1 | xxd -r -p | base64 }
        function c() { printf "%s\n" "$@" | bc -l; }
        function kitty-reload() { kill -SIGUSR1 $(pidof kitty) }
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
      ${stty}
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
    shellAliases = let
      home = config.home.homeDirectory;
      dotfiles = "${home}/dotfiles";
      lila-deploy = "cd ${home}/lila; python bin/deploy";
    in {
      "nswitch" = "nh os switch ${dotfiles}";
      "ntry" = "nh os test ${dotfiles}";
      "ndry" = "nh os test ${dotfiles} --dry";
      "nup" = "nh os switch --update ${dotfiles}";
      "locks" = ''
        git add flake.lock nvim/lazy-lock.json && git commit -m "locks" && git push'';
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
      "man" = "batman";
      # Add suffix alias for less
      "-g L" = "| less";
      "v" = "nvim";
      "x" = "dtrx";
      "reload" = ". ~/.zshrc";
      "meteo" = "curl -4 http://wttr.in/44600";
      "lipass" = "PASSWORD_STORE_DIR=~/lichess-sysadmin/pass pass";
      # deploy
      "stage-assets" = "${lila-deploy} snafu-assets";
      "stage-server" = "${lila-deploy} snafu-server";
      "prod-assets" = "${lila-deploy} manta-assets";
      "prod-server" = "${lila-deploy} manta-server";
      # Stuff
      "st" = "_ systemctl-tui";
      "on" = ''swaymsg " output * power on"'';
    };
  };
}
