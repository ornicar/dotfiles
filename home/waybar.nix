{ ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        modules-left = ["sway/workspaces" "sway/scratchpad" "custom/media"];
        modules-center = ["sway/window"];
        modules-right = ["cpu" "temperature#cpu" "memory" "network" "pulseaudio" "backlight" "battery" "power-profiles-daemon" "tray" "clock#utc" "clock#local"];
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        # idle_inhibitor = {
        #   format = "{icon}";
        #   format-icons = {
        #     activated = "";
        #     deactivated = "";
        #   };
        # };
        "power-profiles-daemon" = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            "power-saver" = "";
          };
        };
        "clock#local" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        "clock#utc" = {
          timezone = "UTC";
          format-alt = "{:%Y-%m-%d}";
        };
        "cpu" = {
          interval = 1;
          format = "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}{icon8}{icon9}{icon10}{icon11}{icon12}{icon13}{icon14}{icon15}";
          format-icons = ["" "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          states = {
            warning = 50;
            critical = 70;
          };
        };
        "memory" = {
          format = " {}%";
          states = {
            warning = 70;
            critical = 85;
          };
        };
        "temperature#cpu" = {
          interval = 1;
          "hwmon-path" = "/sys/class/thermal/thermal_zone3/temp";
          critical-threshold = 70;
          format = "{icon} {temperatureC}°";
          format-icons = [""];
        };
        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };
        "battery" = {
          interval = 5;
          states = {
            good = 80;
            warning = 40;
            critical = 20;
          };
          format = "{icon} {capacity}% {power:2.1f}W";
          format-charging = " {capacity}% {power:2.1f}W";
          format-plugged = " {capacity}% {power:2.1f}W";
          format-alt = "{icon} {time}";
          format-icons = ["" "" "" "" ""];
        };
        "network" = {
          "format-wifi" = "{essid} {signalStrength}% ";
          "format-ethernet" = " {ifname}";
          "tooltip-format" = " {ifname} via {gwaddr}";
          "format-linked" = " {ifname} (No IP)";
          "format-disconnected" = "Disconnected ⚠ {ifname}";
          "format-alt" = " {ifname}: {ipaddr}/{cidr}";
        };
      };
    };
style = /* css */ ''
window#waybar > box {
  opacity: 0.9;
}
#workspaces {
  opacity: 0.6;
}
.modules-right label {
  margin: 0 5px;
}
#cpu {
  opacity: 0.6;
}
.good {
  color: @base0B;
}
.warning:not(.charging) {
  color: @base09;
}
.critical:not(.charging),
#network.disconnected {
  color: @base08;
}
#battery.charging,
#battery.plugged {
  color: @base0B;
}
#battery:not(.charging) {
  font-weight: bold;
}
#battery.critical:not(.charging) {
  background-color: red;
  color: #ffffff;
  font-weight: bold;
}
#workspaces button.urgent {
  background-color: @base09;
}
#clock {
  font-weight: bold;
}
'';
  };
}
