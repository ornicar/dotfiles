{ pkgs, config, ... }: {

  # fan controller
  boot.kernelModules = [ "nct6687" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ nct6687d ];

  # argb controller
  # environment.systemPackages = with pkgs; [ openrgb-plugin-hardwaresync ];

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };
}
