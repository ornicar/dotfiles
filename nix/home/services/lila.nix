{ pkgs, config, inputs, ... }: {
  systemd.user.services = let
    home = config.home.homeDirectory;
    bloop = "${pkgs.bloop}/bin/bloop";
    picfit = "${inputs.picfit.defaultPackage.x86_64-linux}/bin/picfit";
  in {
    lila = {
      Unit = {
        Description = "lila";
        Wants = [ "lila-ws.service" "lila-watch.service" ];
      };
      Service = {
        WorkingDirectory = "${home}/lila";
        ExecStart = "${bloop} run lila";
        ExecStop = "${pkgs.psmisc}/bin/fuser -k 9663/tcp -TERM";
      };
      Install = { WantedBy = [ "multi-user.target" ]; };
    };
    lila-watch = {
      Unit = { Description = "lila-watch"; };
      Service = {
        Environment = "DISPLAY=:0";
        ExecStart = pkgs.writeShellScript "lila-watch.sh" ''
          journalctl --user --since=now -fu lila | ${pkgs.gawk}/bin/awk '\
          /Listening for HTTP on / { system("${pkgs.libnotify}/bin/notify-send \"lila ready\" -t 1000 -u low") } \
          /Failed with result / { system("${pkgs.libnotify}/bin/notify-send \"lila fail\" -t 2000 -u critical") }'
        '';
      };
      Install = { WantedBy = [ "multi-user.target" ]; };
    };
    lila-ws = {
      Unit = { Description = "lila-ws"; };
      Service = {
        WorkingDirectory = "${home}/lila-ws";
        ExecStart =
          "${bloop} run lila-ws -- -J-Dcsrf.origin=http://l.org -J-Dlogback.configurationFile=logback.dev.xml";
        ExecStop = "${pkgs.psmisc}/bin/fuser -k 9664/tcp -TERM";
      };
      Install = { WantedBy = [ "lila.target" ]; };
    };
    lila-fishnet = {
      Unit = { Description = "lila-fishnet"; };
      Service = {
        WorkingDirectory = "${home}/lila-fishnet";
        ExecStart = "${bloop} run app";
      };
      Install = { WantedBy = [ "lila.target" ]; };
    };
    # lila-search = {
    #   Unit = {
    #     Description = "lila-search";
    #   };
    #   Service = {
    #     ExecStart = "${bloop} run lila-search -m play.core.server.ProdServerStart -c ${home}/lila-search/.bloop";
    #     ExecStop = "rm ${home}/lila-search/RUNNING_PID";
    #   };
    #   Install = {
    #     WantedBy = [ "multi-user.target" ];
    #   };
    # };
    picfit = {
      Unit = { Description = "Picfit lila image server"; };
      Service = {
        ExecStart = "${picfit} -c ${home}/picfit/config.json";
        StandardOutput = "journal";
        StandardError = "journal";
        SyslogIdentifier = "picfit";
      };
      Install = { WantedBy = [ "lila.target" ]; };
    };
  };
}
