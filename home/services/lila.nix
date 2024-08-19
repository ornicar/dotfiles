{ pkgs, config, ... }: {
  systemd.user.services = let
    home = config.home.homeDirectory;
    bloop = "${pkgs.bloop}/bin/bloop";
  in {
    lila = {
      Unit = {
        Description = "lila";
        Wants = [ "bloop.service" "lila-ws.service" "lila-watch.service" ];
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
      Unit = {
        Description = "lila-ws";
        Requires = [ "bloop.service" ];
      };
      Service = {
        WorkingDirectory = "${home}/lila-ws";
        ExecStart =
          "${bloop} run lila-ws -- -J-Dcsrf.origin=http://l.org -J-Dlogback.configurationFile=logback.dev.xml";
        ExecStop = "${pkgs.psmisc}/bin/fuser -k 9664/tcp -TERM";
      };
      Install = { WantedBy = [ "lila.target" ]; };
    };
    lila-fishnet = {
      Unit = {
        Description = "lila-fishnet";
        Requires = [ "bloop.service" ];
      };
      Service = {
        ExecStart =
          "${bloop} run lila-fishnet -m play.core.server.ProdServerStart -c ${home}/lila-fishnet/.bloop";
        ExecStop = "rm ${home}/lila-fishnet/RUNNING_PID";
      };
      Install = { WantedBy = [ "lila.target" ]; };
    };
    # lila-search = {
    #   Unit = {
    #     Description = "lila-search";
    #     Requires = [ "bloop.service" ];
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
        ExecStart = "${home}/picfit/bin/picfit -c ${home}/picfit/config.json";
        StandardOutput = "journal";
        StandardError = "journal";
        SyslogIdentifier = "picfit";
      };
      Install = { WantedBy = [ "lila.target" ]; };
    };
  };
}
