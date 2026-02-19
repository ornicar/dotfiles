{ config, ... }:
{

  # fan controller
  boot.kernelModules = [ "nct6687" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ nct6687d ];

  boot.blacklistedKernelModules = [ "mt7921e" ];

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };
}
