{
  pkgs,
  config,
  lib,
  ...
}:
let
  home = config.home.homeDirectory;
  lila-deploy = "cd ${home}/lila; python bin/deploy";
in
{
  home.packages = with pkgs; [
    oxlint
    oxfmt
  ];

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
  programs.ssh.extraConfig = lib.mkAfter ''
    Host manta
      HostName manta.lichess.ovh
      User root
    Host kaiju
      HostName kaiju.lichess.ovh
      User root
    Host rodan
      HostName rodan.lichess.ovh
      User root
    Host snafu
      HostName 141.94.96.141
      User root
    Host rubik-nokey
      HostName rubik.lichess.ovh
      User root
      IdentityFile ~/.ssh/id_nokey
  '';
}
