{ pkgs, lib, ... }: {
  programs.waybar = {
    settings = {
      mainBar = {
        modules-left = lib.mkAfter [ "custom/spotify" ];
        modules-right = [
          "cpu"
          "temperature#cpu"
          "custom/amdgpu"
          "memory"
          # "custom/files"
          "network"
          "pulseaudio"
          # "custom/lan-mouse"
          "tray"
          "clock#utc"
          "clock#local"
        ];
        "cpu" = {
          interval = 1;
          format =
            "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}{icon8}{icon9}{icon10}{icon11}{icon12}{icon13}{icon14}{icon15}{icon16}{icon17}{icon18}{icon19}{icon20}{icon21}{icon22}{icon23}";
          format-icons = [ "" "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
          states = {
            warning = 20;
            critical = 50;
          };
        };
        "temperature#cpu" = {
          interval = 1;
          hwmon-path = "/sys/class/hwmon/hwmon6/temp1_input";
          critical-threshold = 60;
          format = "{icon} {temperatureC}°";
          format-icons = [ "" ];
        };
        "custom/amdgpu" = {
          interval = 1;
          format = " {}";
          exec = pkgs.writeShellScript "thib-amdgpu-waybar" ''
            power=$(cat /tmp/gpu-power)
            temp=$(cat /tmp/gpu-temp)
            echo "''${power}W $temp°"
          '';
        };
        "custom/spotify" = {
          interval = 5;
          exec = ''
            ${pkgs.playerctl}/bin/playerctl -p spotify metadata --format "{{xesam:artist}} - {{xesam:album}}"'';
          format = "♫ {}";
          max-length = 70;
          on-click = "${pkgs.playerctl}/bin/playerctl -p spotify play-pause";
        };
        "custom/files" = {
          interval = 1;
          format = " {}";
          exec = ''
            awk '{print $1}' /proc/sys/fs/file-nr
          '';
        };
      };
    };
  };
}
