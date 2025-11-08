{ config, pkgs, ... }: {

  systemd.user.services = let scala-cli = "${pkgs.scala-cli}/bin/scala-cli";
  in {
    lichess-mod-auth-stream = {
      Unit = {
        Description = "Lichess mod";
        After = [ "network-online.target" ];
      };
      Install = { WantedBy = [ "default.target" ]; };
      Service = {
        WorkingDirectory = "${config.home.homeDirectory}/lichess-mod";
        ExecStart = "${scala-cli} auth-stream.sc";
        StandardOutput = "journal";
        StandardError = "journal";
        SyslogIdentifier = "lichess-mod-auth-stream";
        Restart = "on-failure";
        RestartSec = 5;
      };
    };
  };
}
