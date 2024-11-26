{ pkgs, inputs, ... }: {

  environment.systemPackages = with pkgs; [
    jdk
    nodejs_22
    sbt
    bloop
    coursier # required by metals
    metals
    dart-sass
    redis
    inputs.bbpPairings.packages.x86_64-linux.default
    inputs.picfit.defaultPackage.x86_64-linux
  ];

  programs.java.enable = true;

  services.redis.servers."".enable = true;
}
