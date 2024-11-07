{ ... }:
let enable = false; # save energy until we need it
in {
  hardware.bluetooth.enable = enable;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = enable;
}
