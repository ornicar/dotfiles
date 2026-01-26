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
        bind = [
          ", F8, exec, ${pkgs.playerctl}/bin/playerctl -p spotify play-pause"
          ", F9, exec, ${volumeDec}"
          ", F10, exec, ${volumeInc}"
          "$mod, F10, exec, screenshot.sh clipboard"
        ];
      };
  };
}
