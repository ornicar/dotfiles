# crom is my desktop PC
{ inputs, lib, ... }: {
  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    ./amdgpu.nix
    ./keyd.nix
    ../modules/common.nix
    ../modules/bluetooth.nix
    ../modules/coolercontrol.nix
  ];

  # Open ports in the firewall.
  programs.mosh.enable = true;

  networking = {
    hostName = "crom";
    extraHosts = "192.168.1.3 fw";
    firewall.allowedTCPPorts = [
      80
      443
      9371 # puzzler
      # 11987 # coolercontrol
    ];
  };

  stylix.fonts.sizes = lib.mkForce {
    applications = 14;
    desktop = 14;
    popups = 16;
    terminal = 16;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
