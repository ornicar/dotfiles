{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ../modules/hyprland.nix ];

  wayland.windowManager.hyprland = {
    settings =
      let
        inherit (config.wayland.windowManager.hyperland.config) "$mod";
        spotify = "${pkgs.playerctl}/bin/playerctl -p spotify";
        home = config.home.homeDirectory;
        volumeDec = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0";
        volumeInc = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0";
        voltoggle = "audioctl sink toggle";
      in
      lib.mkAfter {
        general = {
          gaps_in = lib.mkForce 7;
          gaps_out = lib.mkForce "10, 10, 2, 10";
        };
        bind = [
          ", F8, exec, ${pkgs.playerctl}/bin/playerctl -p spotify play-pause"
          ", F9, exec, ${volumeDec}"
          ", F10, exec, ${volumeInc}"
          "$mod, F10, exec, screenshot.sh clipboard"
          "$mod, B, togglespecialworkspace, mic"
          "$mod SHIFT, B, movetoworkspace, special:mic"
        ];
        input = {
          repeat_delay = lib.mkForce "250";
          # accel_profile = lib.mkForce "flat";
        };
      };
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
