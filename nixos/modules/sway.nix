{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wayland
    swaylock
    swayidle
    mako
    dracula-theme
    gnome3.adwaita-icon-theme
    wl-clipboard
    bemenu
    waybar
    # dbus-sway-environment
    # configure-gtk
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
