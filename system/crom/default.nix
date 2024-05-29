# crom is my desktop PC
{ pkgs, inputs, ... }: {
  imports = [ ./hardware.nix ../modules/common.nix ../modules/bluetooth.nix ];

  environment.systemPackages = with pkgs; [
    lm_sensors
    coolercontrol.coolercontrold
    coolercontrol.coolercontrol-gui
  ];

  programs.coolercontrol.enable = true;

  # Open ports in the firewall.
  programs.mosh.enable = true;

  networking = {
    hostName = "crom";
    extraHosts = "192.168.1.3 fw";
    firewall.allowedTCPPorts = [
      80
      443
      9371 # puzzler
      11987 # coolercontrol
    ];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
