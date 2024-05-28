{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  networking.networkmanager.enable = true;

  programs.nm-applet.enable = true;

  networking.stevenblack.enable = true;
}
