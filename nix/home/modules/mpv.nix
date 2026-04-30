{ pkgs, ... }:
{

  programs.mpv = {
    enable = false;
    config = {
      target-colorspace-hint = false;
    };
  };
}
