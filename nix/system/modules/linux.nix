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
    pciutils
    usbutils
    unixtools.xxd
    iprange
    ps_mem
    bc # calculator
    unixtools.netstat
  ];

  # enable zsh completion for system packages
  environment.pathsToLink = [ "/share/zsh" ];

  services.logind.settings.Login = {
    HandlePowerKey = "suspend";
    HandleLidSwitch = "suspend";
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
