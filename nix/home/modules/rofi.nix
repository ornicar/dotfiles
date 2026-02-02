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
  };
  stylix.targets.rofi.enable = false;
}
