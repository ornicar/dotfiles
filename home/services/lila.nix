{ pkgs, lib, config, ... }: {
  systemd.user.services = let
    home = config.home.homeDirectory;
    bins = "/run/current-system/sw/bin";
    bloop = "${bins}/bloop";
  in {
    lila = {
      Unit = {
        Description = "lila";
        Wants = [ "bloop.service" "lila-ws.service" ];
      };
      Service = {
        ExecStart = "${bloop} run lila -m lila.app.Lila -c ${home}/lila/.bloop";
        ExecStop = "${bins}/fuser -k 9663/tcp -TERM";
      };
      Install = { WantedBy = [ "multi-user.target" ]; };
    };
    lila-watch = {
      Unit = { Description = "lila-watch"; };
      Service = {
        Environment = "DISPLAY=:0";
        ExecStart = "${home}/.local/bin/lila-watch.sh";
      };
      Install = { WantedBy = [ "multi-user.target" ]; };
    };
    lila-ws = {
      Unit = {
        Description = "lila-ws";
        Requires = [ "bloop.service" ];
      };
      Service = {
        ExecStart =
          "${bloop} run lila-ws -m lila.ws.LilaWs -c ${home}/lila-ws/.bloop -- -J-Dcsrf.origin=http://localhost:9663 -J-Dlogback.configurationFile=logback.dev.xml";
        ExecStop = "${bins}/fuser -k 9664/tcp -TERM";
      };
      Install = { WantedBy = [ "multi-user.target" ]; };
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
      Install = { WantedBy = [ "multi-user.target" ]; };
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
      Install = { WantedBy = [ "default.target" ]; };
    };
  };
}
