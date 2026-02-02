{ pkgs, ... }:
{

  programs.rofi = {
    enable = true;
    theme = "material";
    plugins = [
      pkgs.rofi-emoji
      pkgs.rofi-calc
    ];
    modes = [
      "window"
      "run"
      "emoji"
      "calc"
    ];
    font = "JetBrains Mono 17";
  };
  stylix.targets.rofi.enable = false;
}
