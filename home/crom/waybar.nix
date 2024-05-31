{ pkgs, lib, ... }: {
  programs.waybar = {
    settings = {
      mainBar = {
        modules-right = [
          "cpu"
          "temperature#cpu"
          "custom/amdgpu"
          "memory"
          "network"
          "pulseaudio"
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
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 60;
          format = "{icon} {temperatureC}°";
          format-icons = [ "" ];
        };
        "custom/amdgpu" = {
          interval = 2;
          format = "GPU {}";
          exec = let
            device = "amdgpu-pci-0800";
            sensors = "${pkgs.lm_sensors}/bin/sensors";
            sed = "${pkgs.gnused}/bin/sed";
          in pkgs.writeShellScript "thib-amdgpu-waybar" ''
            sens=$(${sensors} ${device})
            power=$(echo $sens | ${sed} -rn 's/.*PPT:\s+([0-9]+).*/\1/p')
            temp=$(echo $sens | ${sed} -rn 's/.*edge:\s+.([0-9]+).*/\1/p')
            echo "''${power}W $temp°"
          '';
        };
      };
    };
  };
}
