{ config, ... }: {

  boot.kernelModules = [ "nct6687" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ nct6687d ];
}
