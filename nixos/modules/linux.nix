{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    fzf
    fd
    jq
    bat
    httpie
    mosh
    dust
  ];

  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';
}
