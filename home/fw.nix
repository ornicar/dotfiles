# frame.work 16 home config
{ inputs, lib, config, pkgs, ... }: {
  imports = [ ./common.nix ./modules/barrier.nix ];

  wayland.windowManager.sway = {
    config = {
      input = {
        "type:keyboard" = {
          xkb_layout = "us,us";
          xkb_variant = "colemak,";
          repeat_rate = "56";
          repeat_delay = "180";
        };
        "type:touchpad" = {
          left_handed = "disabled";
          tap = "enabled";
          natural_scroll = "disabled";
          # dwt = "enabled";
          accel_profile =
            "adaptive"; # disable mouse acceleration (enabled by default; to set it manually, use "adaptive" instead of "flat")
          pointer_accel = "0.3"; # set mouse sensitivity (between -1 and 1)
        };
      };
    };
    extraConfig = ''
      bindsym XF86MonBrightnessDown exec 'light -U 10';
      bindsym XF86MonBrightnessUp exec 'light -A 10';
      bindsym XF86AudioRaiseVolume exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0';
      bindsym XF86AudioLowerVolume exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0';
      bindsym XF86AudioMute exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle';
      bindsym XF86AudioPlay exec 'playerctl play-pause';
      bindsym XF86AudioNext exec 'playerctl next';
      bindsym XF86AudioPrev exec 'playerctl previous';
      bindsym Print exec 'screenshot.sh clipboard';
    '';
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
