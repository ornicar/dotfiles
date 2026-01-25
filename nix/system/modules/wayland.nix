{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wayland
    wlr-randr
    libnotify
    glib # gsettings
    grim
    slurp
    mako # notification daemon
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    xdg-utils
    waybar
  ];

  hardware.graphics.enable = true;
}
