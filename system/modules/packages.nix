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
    zulip
    signal-desktop
    discord
    neofetch
    spotify
    playerctl
    zeroad
    gimp
    gthumb
    feh
    libnotify
    barrier
    tmux
    gnome.nautilus
    stockfish
    cmatrix
  ];
}
