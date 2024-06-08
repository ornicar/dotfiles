# fw is my frame.work 16
{ pkgs, inputs, ... }: {
  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ./ectool.nix
    ./keyd.nix
    ../modules/common.nix
    ../modules/bluetooth.nix
    ../modules/coolercontrol.nix
  ];

  environment.systemPackages = with pkgs; [ powertop fw-ectool libinput ];

  networking = {
    hostName = "fw";
    extraHosts = ''
      192.168.1.2 crom
    '';
  };

  programs.nm-applet.enable = true;

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
  services.fprintd.enable = true;

  hardware.keyboard.qmk.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
