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
    settings =
      let
        inherit (config.wayland.windowManager.hyperland.config) "$mod";
        spotify = "${pkgs.playerctl}/bin/playerctl -p spotify";
        home = config.home.homeDirectory;
        volup = "audioctl sink inc";
        voldown = "audioctl sink dec";
        voltoggle = "audioctl sink toggle";
        light = "${pkgs.brightnessctl}/bin/brightnessctl";
      in
      lib.mkAfter {
        input = {
          touchpad = {
            disable_while_typing = true; # doesn't work
          };
        };
        workspace = [
          # Full screen single visible tiled window, except special workspace
          "w[tv1] s[false], gapsout:0, gapsin:0, decorate:false, rounding:false, shadow:false"
        ];
        bind = [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, ${spotify} play-pause"
          ", XF86AudioNext, exec, ${spotify} next"
          ", XF86AudioPrev, exec, ${spotify} previous"
          ", Print, exec, ${home}/dotfiles/scripts/screenshot.sh clipboard"
          ", F10, exec, ${home}/dotfiles/scripts/systemctl-toggle.sh easyeffects"
        ];
        binde = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.5"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 0.0"
          ", XF86MonBrightnessDown, exec, ${light} set 10%-"
          ", XF86MonBrightnessUp, exec, ${light} set +10%"
        ];
      };
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
