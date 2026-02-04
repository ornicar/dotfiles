{ pkgs, ... }:
{

  programs.mpv = {
    enable = true;
    config = {
      target-colorspace-hint = false;
    };
  };
}
