{ pkgs, inputs, ... }: {

  imports = [ ../modules/mongodb.nix ];

  environment.systemPackages = with pkgs; [
    jdk23
    corepack_23 # gives a pnpm bundled with node23
    sbt
    bloop
    coursier # required by metals
    metals
    dart-sass
    redis
    fishnet
    fontforge # icon font editor
    inputs.bbpPairings.packages.x86_64-linux.default
    inputs.picfit.defaultPackage.x86_64-linux
  ];

}
