{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../modules/hyprland.nix
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
      in
      lib.mkAfter {
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
          ", XF86MonBrightnessDown, exec, light -U 10"
          ", XF86MonBrightnessUp, exec, light -A 10"
        ];
      };
  };
}
