# frame.work 16 home config
{ pkgs, ... }: {
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
          accel_profile = "adaptive";
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

  programs.waybar = {
    settings = {
      mainBar = {
        modules-right = [
          "cpu"
          "temperature#cpu"
          "memory"
          "network"
          "pulseaudio"
          "backlight"
          "battery"
          "power-profiles-daemon"
          "tray"
          "clock#utc"
          "clock#local"
        ];
      };
      "cpu" = {
        interval = 1;
        format =
          "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}{icon8}{icon9}{icon10}{icon11}{icon12}{icon13}{icon14}{icon15}";
        format-icons = [ "" "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        states = {
          warning = 20;
          critical = 50;
        };
      };
      "temperature#cpu" = {
        interval = 1;
        hwmon-path = "/sys/class/thermal/thermal_zone3/temp";
        critical-threshold = 70;
        format = "{icon} {temperatureC}°";
        format-icons = [ "" ];
      };
      "backlight" = {
        format = "{icon} {percent}%";
        format-icons = [ "" "" "" "" "" "" "" "" "" ];
      };
      "battery" = {
        interval = 5;
        states = {
          good = 100;
          warning = 50;
          critical = 25;
        };
        format = "{icon} {capacity}% {power:2.1f}W";
        format-charging = " {capacity}% {power:2.1f}W";
        format-plugged = " {capacity}% {power:2.1f}W";
        format-alt = "{icon} {time}";
        format-icons = [ "" "" "" "" "" ];
      };
      "power-profiles-daemon" = {
        format = "{icon}";
        tooltip-format = ''
          Power profile: {profile}
          Driver: {driver}'';
        tooltip = true;
        format-icons = {
          default = "";
          performance = "";
          balanced = "";
          "power-saver" = "";
        };
      };
    };
  };

  services.swayidle = {
    enable = true;
    timeouts = [{
      timeout = 600;
      command = ''${pkgs.sway}/bin/swaymsg "output * power off"'';
      resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * power on"'';
    }];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
