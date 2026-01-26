{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wayland
    wlr-randr
    libnotify
    grim # screenshot
    slurp # visual region selection
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    xdg-utils
  ];

  hardware.graphics.enable = true;
}
