{ ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "sway/window" ];
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          window-rewrite = { }; # just to get rid of the warning
        };
        "sway/mode" = { "format" = " {}"; };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        # "sway/language" = {
        #   "tooltip-format" = "{long}";
        #   "format" = " {variant}";
        # };
        "clock#local" = {
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          format-alt = "{:%Y-%m-%d}";
        };
        "clock#utc" = {
          timezone = "UTC";
          format-alt = "{:%Y-%m-%d}";
        };
        "memory" = {
          format = " {percentage}%  {swapPercentage}%";
          states = {
            warning = 70;
            critical = 85;
          };
        };
        "network" = {
          interval = 1;
          # "format-wifi" = " {essid} {signalStrength}% {bandwidthTotalBytes}";
          "format-wifi" = " {essid} {signalStrength}%";
          "tooltip-format" = "{bandwidthTotalBytes} {ifname} via {gwaddr}";
          "format-linked" = " {ifname} (No IP)";
          "format-disconnected" = "Disconnected ⚠ {ifname}";
          "format-alt" = " {ifname}: {ipaddr}/{cidr}";
        };
        pulseaudio = {
          "scroll-step" = 2;
          "format" = "{icon}  {volume}%";
          #"format-bluetooth"= "{icon}  {volume}%";
          "format-muted" = "";
          "format-icons" = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "" "" ];
          };
          "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
      };
    };
    style = # css
      ''
        window#waybar > box {
          opacity: 0.9;
        }
        #workspaces {
          opacity: 0.6;
        }
        .modules-right label {
          margin: 0 5px;
        }
        #tray {
          margin: 0 15px;
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
        #clock.utc {
          margin: 0;
        }
        #clock.local {
          font-weight: bold;
        }
        #idle_inhibitor.activated {
          background-color: @base08;
          font-weight: bold;
          color: #ffffff;
        }
        #custom-spotify {
          margin-left: 20px;
          color: @base0E;
        }
      '';
  };
}
