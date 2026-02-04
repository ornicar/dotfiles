{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    wget
    tldr
    xdg-utils
    ffmpeg
    btop
    htop
    zip
    unzip
    dtrx
    signal-desktop
    neofetch
    spotify
    playerctl
    gimp
    gthumb
    feh
    nautilus
    stockfish
    lm_sensors
    gping # ping with a graph
    trippy # network diagnostic https://github.com/fujiapple852/trippy
    vlc
    evince # pdf viewer
    ghostscript
    libreoffice-qt
    imagemagick
  ];
}
