{ pkgs, ... }: {

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  environment.variables = {
    EDITOR = "nvim";
    TERM = "xterm-kitty";
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

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}
