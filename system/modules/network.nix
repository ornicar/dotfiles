{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];

  networking.networkmanager.enable = true;

  networking.stevenblack.enable = true;
}
