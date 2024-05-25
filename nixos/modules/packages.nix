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
    zulip
    redshift
    signal-desktop
    discord
    neofetch
    spotify
    marksman
    zeroad
    gimp
  ];
}
