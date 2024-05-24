{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
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
    nh
  ];
}
