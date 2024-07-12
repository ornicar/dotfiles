{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    wayland
    wlr-randr
    wget
    tldr
    xdg-utils
    glib
    ffmpeg
    btop
    firefox
    google-chrome
    unzip
    dtrx
    signal-desktop
    neofetch
    spotify
    playerctl
    # zeroad
    gimp
    gthumb
    feh
    libnotify
    nautilus
    stockfish
    lm_sensors
    gping # ping with a graph
    trippy # network diagnostic https://github.com/fujiapple852/trippy
    mpv
  ];
}
