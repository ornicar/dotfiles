{ pkgs, inputs, ... }: {

  environment.systemPackages = with pkgs; [
    jdk
    nodejs_23
    sbt
    bloop
    coursier # required by metals
    metals
    dart-sass
    mongodb
    redis
    inputs.bbpPairings.packages.x86_64-linux.default
    inputs.picfit.defaultPackage.x86_64-linux
  ];

}
