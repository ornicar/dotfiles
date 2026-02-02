{ lib, ... }:
{
  programs.ashell = {
    enable = true;
    systemd.enable = true;
    settings = {
      position = "Bottom";
      appearance = {
        scale_factor = 1.3;
        opacity = lib.mkForce 0.5;
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
            "Clock"
            "Tray"
            "Privacy"
            "Settings"
          ]
        ];
      };
    };
  };
}
