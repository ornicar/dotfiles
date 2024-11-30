{ pkgs, config, ... }:
let
  home = config.home.homeDirectory;
  lila-deploy = "cd ${home}/lila; python bin/deploy";
in {

  home.sessionVariables = {
    # for lila/ui/build to find the sass executable
    SASS_PATH = "${pkgs.dart-sass}/bin/dart-sass";
  };
  programs.zsh.shellAliases = {
    # deploy
    "stage-assets" = "${lila-deploy} snafu-assets";
    "stage-server" = "${lila-deploy} snafu-server";
    "prod-assets" = "${lila-deploy} manta-assets";
    "prod-server" = "${lila-deploy} manta-server";
  };
}
