{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    glib # gsettings
    swaylock
    swayidle
    grim
    slurp
    mako # notification daemon
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    bemenu # wayland clone of dmenu
    xdg-utils
    waybar
  ];
}
