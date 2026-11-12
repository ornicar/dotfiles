{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ../modules/hyprland.nix ];

  home.packages = with pkgs; [
    brightnessctl
  ];

  wayland.windowManager.hyprland = {
    extraConfig = ''
      require("~/dotfiles/nix/home/fw/hyprland.lua")
    '';
  };

  services.hypridle = {
    enable = true;
    settings =
      let
        light = "${pkgs.brightnessctl}/bin/brightnessctl";
      in
      {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 300;
            on-timeout = "${light} --save; ${light} --min-value";
            on-resume = "${light} --restore";
          }
          {
            timeout = 600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 1500;
            on-timeout = "systemctl suspend";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
  };
}
