{ pkgs, config, ... }:
let
  home = config.home.homeDirectory;
  bins = "/run/current-system/sw/bin";
in
{
  systemd.user.services.lila = {
    Unit = {
      Description = "lila";
      Wants = [ "bloop.service" "lila-ws.service" ];
    };
    Service = {
      ExecStart = "${pkgs.bloop}/bin/bloop run lila -m lila.app.Lila -c ${home}/lila/.bloop";
      ExecStop = "${bins}/fuser -k 9663/tcp -TERM";
    };
    Install = {
      WantedBy = [ "multi-user.target" ];
    };
  };
  systemd.user.services.lila-watch = {
    Unit = {
      Description = "lila-watch";
    };
    Service = {
      Environment="DISPLAY=:0";
      ExecStart = ''
        ${bins}/journalctl --user --since=now -fu lila | ${bins}/awk '\
        /Listening for HTTP on / { system("notify-send \"lila ready\" -t 1000 -u low") } \
        /Failed with result / { system("notify-send \"lila fail\" -t 1000 -u critical") }'
      '';
    };
    Install = {
      WantedBy = [ "multi-user.target" ];
    };
  };
  systemd.user.services.lila-ws = {
    Unit = {
      Description = "lila-ws";
      Requires = [ "bloop.service" ];
    };
    Service = {
      ExecStart = "${pkgs.bloop}/bin/bloop run lila-ws -m lila.ws.LilaWs -c ${home}/lila-ws/.bloop -- -J-Dcsrf.origin=http://localhost:9663 -J-Dlogback.configurationFile=logback.dev.xml";
      ExecStop = "${bins}/fuser -k 9664/tcp -TERM";
    };
    Install = {
      WantedBy = [ "multi-user.target" ];
    };
  };
  systemd.user.services.lila-fishnet = {
    Unit = {
      Description = "lila-fishnet";
      Requires = [ "bloop.service" ];
    };
    Service = {
      ExecStart = "${pkgs.bloop}/bin/bloop run lila-fishnet -m play.core.server.ProdServerStart -c ${home}/lila-fishnet/.bloop";
      ExecStop = "rm ${home}/lila-fishnet/RUNNING_PID";
    };
    Install = {
      WantedBy = [ "multi-user.target" ];
    };
  };
  systemd.user.services.lila-search = {
    Unit = {
      Description = "lila-search";
      Requires = [ "bloop.service" ];
    };
    Service = {
      ExecStart = "${pkgs.bloop}/bin/bloop run lila-search -m play.core.server.ProdServerStart -c ${home}/lila-search/.bloop";
      ExecStop = "rm ${home}/lila-search/RUNNING_PID";
    };
    Install = {
      WantedBy = [ "multi-user.target" ];
    };
  };
}
