{ config, ... }: {

  systemd.user.services.lila-http = let
    dir = "${config.home.homeDirectory}/lila-http";
    lila-http = "${dir}/target/release/lila-http";
    redis-url = "redis://localhost";
    bind = "127.0.0.1:3882";
  in {
    Unit = {
      Description = "Cooklang chef";
      After = [ "network-online.target" ];
    };
    Service = {
      ExecStart = "${lila-http} --redis-url ${redis-url} --bind ${bind}";
      WorkingDirectory = dir;
    };
    Install = { WantedBy = [ "default.target" ]; };
  };
}
