{ lib, ... }:
{
  stylix.targets.ashell.enable = true;
  programs.ashell = {
    enable = true;
    systemd.enable = true;
    settings = {
      position = "Bottom";
      appearance = {
        scale_factor = 1.4;
        opacity = lib.mkForce 0.4;
        menu = {
          opacity = lib.mkForce 0.4;
          backdrop = 0.2;
        };
      };
      settings = {
        remove_airplane_btn = true;
        indicators = [
          "IdleInhibitor"
          "PowerProfile"
          "Audio"
          "Bluetooth"
          "Network"
          "Battery"
        ];
      };
      system_info = {
        indicators = [
          "Memory"
          "Cpu"
          "Temperature"
        ];
      };
      tempo = {
        clock_format = "%a %d %b %R %Z";
        timezones = [
          "Europe/Paris"
          "UTC"
        ];
        weather_location = {
          City = "Saint-Nazaire";
        };
        wind_speed_unit = "Kmh";
      };
      modules = {
        left = [
          "Workspaces"
          "MediaPlayer"
        ];
        center = [
          "WindowTitle"
        ];
        right = [
          "SystemInfo"
          # "KeyboardLayout"
          [
            "Tempo"
            "Tray"
            "Privacy"
            "Settings"
          ]
        ];
      };
    };
  };
}
