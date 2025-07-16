{ pkgs, ... }: {

  # https://www.nexusmods.com/skyrimspecialedition/mods/91500?tab=files&file_id=464258
  home.packages = with pkgs; [ protontricks p7zip zenity ];
}
