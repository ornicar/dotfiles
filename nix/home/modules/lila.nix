{ pkgs, ... }: {

  home.sessionVariables = {
    # for lila/ui/build to find the sass executable
    SASS_PATH = "${pkgs.dart-sass}/bin/dart-sass";
  };
