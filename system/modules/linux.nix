{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    fzf
    fd
    jq
    bat
    httpie
    mosh
    dust
    psmisc # fuser
  ];

  # enable zsh completion for system packages
  environment.pathsToLink = [ "/share/zsh" ];

  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  # automount removable media
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };
}
