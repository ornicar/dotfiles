{ pkgs, ... }: {

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  environment.variables = {
    EDITOR = "nvim";
    TERM = "xterm-kitty";
  };

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
    XDG_BIN_HOME    = "$HOME/.local/bin";
    PATH = [ "${XDG_BIN_HOME}" ];
    EDITOR = "nvim";
    TERMINAL = "kitty";
  };

  environment.systemPackages = with pkgs; [
    kitty
    zsh
    zsh-syntax-highlighting
    zsh-powerlevel10k
    ripgrep
    eza
    keychain
    zoxide
    fira-code
  ];

  programs.zsh.enable = true;
}
