{ pkgs, inputs, ... }:
let
  pkgs-stable = import inputs.nixpkgs-stable { system = pkgs.stdenv.system; };
in
{

  imports = [ ../modules/mongodb.nix ];

  environment.systemPackages = with pkgs; [
    # jdk24
    jdk25
    sbt
    bloop
    coursier # required by metals
    metals
    dart-sass
    redis
    fishnet
    # fontforge-gtk # icon font editor
    pkgs-stable.inkscape
    inputs.bbpPairings.packages.x86_64-linux.default
    inputs.picfit.defaultPackage.x86_64-linux
  ];

}
