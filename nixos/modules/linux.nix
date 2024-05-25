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

  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';
}
