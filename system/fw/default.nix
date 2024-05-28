# fw is my frame.work 16
{ pkgs, inputs, ... }:
{
  imports =
    [
      ./hardware.nix
      inputs.nixos-hardware.nixosModules.framework-16-7040-amd
      ../modules/common.nix
      ../modules/bluetooth.nix
    ];

  environment.systemPackages = with pkgs; [
    powertop
    fw-ectool
    libinput
  ];

  networking = {
    hostName = "fw";
    extraHosts = ''
192.168.1.2 crom
'';
  };

  powerManagement.enable = true;

  # as per https://github.com/NixOS/nixos-hardware/tree/master/framework
  services.fwupd.enable = true;

  sound.mediaKeys.enable = true;

  # Enable touchpad support
  services.libinput.enable = true;

  # Display backlight
  programs.light.enable = true;
  hardware.sensor.iio.enable = true;

  # fingerprint sensor
  services.fprintd.enable = false;

  hardware.keyboard.qmk.enable = false;

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          # to view key names:
          # sudo keyd -m
          main = {
            capslock = "esc";
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
