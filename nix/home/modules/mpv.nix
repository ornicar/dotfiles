{ pkgs, inputs, ... }:
let
  pkgs-stable = import inputs.nixpkgs-stable { system = pkgs.stdenv.system; };
in
{
  home.packages = with pkgs; [
    pkgs-stable.mpv
  ];

  programs.mpv = {
    enable = false;
    config = {
      target-colorspace-hint = false;
    };
  };
}
