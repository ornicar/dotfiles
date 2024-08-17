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
    lsof
    bind
    gparted
    dmidecode
    unixtools.xxd
    iprange
    ps_mem
  ];

  # enable zsh completion for system packages
  environment.pathsToLink = [ "/share/zsh" ];

  services.logind = {
    powerKey = "suspend";
    lidSwitch = "hibernate";
  };

  # automount removable media
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.openssh = {
    enable = true;
    settings = { PasswordAuthentication = false; };
  };
}
