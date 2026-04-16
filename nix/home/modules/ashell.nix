{ lib, ... }:
{
  programs.ashell = {
    enable = true;
    systemd.enable = true;
    settings = {
      position = "Bottom";
      appearance = {
        scale_factor = 1.3;
        opacity = lib.mkForce 0.6;
        menu = {
          opacity = lib.mkForce 0.7;
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
