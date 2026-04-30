{ pkgs, inputs, ... }:
let
  pkgs-stable = import inputs.nixpkgs-stable { system = pkgs.stdenv.system; };
in
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
    spotify
    playerctl
    gimp
    gthumb
    feh
    pkgs-stable.qimgv # image viewer
    nautilus
    stockfish
    lm_sensors
    gping # ping with a graph
    trippy # network diagnostic https://github.com/fujiapple852/trippy
    vlc
    evince # pdf viewer
    ghostscript
    libreoffice
    imagemagick
  ];
}
