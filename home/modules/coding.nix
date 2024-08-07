{ pkgs, ... }: {

  home.packages = with pkgs; [ bloop ];

  home.sessionVariables = {
    # for lila/ui/build to find the sass executable
    SASS_PATH = "${pkgs.dart-sass}/bin/dart-sass";
  };

  home.file = {
    "./.sbtrc".text = ''
      alias c=compile
      alias cc=~compile
      alias r=run
      alias l=reload
      alias p=project
      alias t=test
      alias tt=~testQuick
    '';
  };
}
