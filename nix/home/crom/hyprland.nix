{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ../modules/hyprland.nix ];

  wayland.windowManager.hyprland = {
    extraConfig = ''
      require("~/dotfiles/nix/home/crom/hyprland.lua")
    '';
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        lock_cmd = "hyprlock";
      };
      listener = [
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
