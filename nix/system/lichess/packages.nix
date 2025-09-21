{ pkgs, inputs, ... }: {

  imports = [ ../modules/mongodb.nix ];

  environment.systemPackages = with pkgs; [
    jdk24
    corepack
    sbt
    bloop
    coursier # required by metals
    metals
    dart-sass
    redis
    fishnet
    fontforge-gtk # icon font editor
    inkscape
    inputs.bbpPairings.packages.x86_64-linux.default
    inputs.picfit.defaultPackage.x86_64-linux
  ];

}
