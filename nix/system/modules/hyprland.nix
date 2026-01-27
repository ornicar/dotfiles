{ inputs, pkgs, ... }:
{
  imports = [ ./wayland.nix ];

  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = false;
  };

  environment.systemPackages = with pkgs; [
    inputs.ashell.packages.${pkgs.system}.default
  ];
}
