{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    wayland
    wget
    tldr
    # firefox
    xdg-utils
    glib
    ffmpeg
    btop
    google-chrome
    unzip
    dtrx
    zulip
    signal-desktop
    discord
    neofetch
    spotify
    playerctl
    marksman
    zeroad
    gimp
    gthumb
    feh
    libnotify
  ];
}
