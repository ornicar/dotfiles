{ pkgs, ... }: {

  home.packages = with pkgs; [ protontricks p7zip zenity ];
}
