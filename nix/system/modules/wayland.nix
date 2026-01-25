{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    glib # gsettings
    grim
    slurp
    mako # notification daemon
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    bemenu
    xdg-utils
    waybar
  ];

  hardware.graphics.enable = true;
}
