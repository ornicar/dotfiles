{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    coolercontrol.coolercontrold
    coolercontrol.coolercontrol-gui
  ];

  programs.coolercontrol = {
    enable = true;
    nvidiaSupport = false;
  };
}
