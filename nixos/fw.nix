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

  # services.actkbd = {
  #   enable = true;
  #   bindings = [
  #     { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
  #     { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
  #   ];
  # };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
