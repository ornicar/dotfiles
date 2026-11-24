{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./wayland.nix
    ./ashell.nix # status bar
    # ./hyprshade.nix # color temperature
    # ./hyprshell.nix
  ];

  services.hyprpaper.enable = true;
  stylix.targets.hyprland.hyprpaper.enable = false;
  stylix.targets.wayprompt.enable = false;

  gtk.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    systemd.enable = false; # https://wiki.nixos.org/wiki/Hyprland
    configType = "lua";
    extraConfig = ''
      require("~/dotfiles/nix/home/modules/hyprland.lua")
    '';
  };
}
