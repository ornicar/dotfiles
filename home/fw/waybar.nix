{ ... }: {
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
      cpu.format =
        "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}{icon8}{icon9}{icon10}{icon11}{icon12}{icon13}{icon14}{icon15}";
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
}
