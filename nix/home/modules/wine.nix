{ pkgs, ... }:
{

  home.packages = with pkgs; [
    # (wineWow64Packages.full.override {
    #   wineRelease = "staging";
    #   mingwSupport = true;
    # })
    # wine64
    # wineWow64Packages.waylandFull
    # support 64-bit only
    # (wine.override { wineBuild = "wine64"; })
    # winetricks
    # protontricks
  ];

  programs.lutris.enable = true;

}
