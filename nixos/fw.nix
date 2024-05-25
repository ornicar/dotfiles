# Framework 16
{ pkgs, ... }:

{
  imports =
    [
      ./hardware/fw.nix
      ./modules/common.nix
      ./modules/bluetooth.nix
    ];

  environment.systemPackages = with pkgs; [
    powertop
    fw-ectool
  ];

  networking.hostName = "fw";

  powerManagement.enable = true;

  # as per https://github.com/NixOS/nixos-hardware/tree/master/framework
  services.fwupd.enable = true;

  sound.mediaKeys.enable = true;

  # Enable touchpad support
  services.libinput.enable = true;

  programs.light.enable = true;
  hardware.sensor.iio.enable = true;

  # fingerprint sensor
  services.fprintd.enable = false;

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          # to view key names:
          # sudo keyd -m
          main = {
            capslock = "overload(control, esc)";
            delete = "S-insert";
            leftmeta = "leftcontrol";
            rightalt = "layer(rightalt)";
          };
          "rightalt:G" = {
            f = "enter";
          };
        };
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
