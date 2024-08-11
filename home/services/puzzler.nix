{ config, pkgs, ... }: {
  systemd.user.services = let
    home = config.home.homeDirectory;
    puzzler = "${home}/lichess-puzzler";
  in {
    puzzler = {
      Unit = {
        Description = "Puzzler validator backend";
        After = [ "mongodb.service" ];
      };
      Install = { WantedBy = [ "default.target" ]; };
      Service = {
        WorkingDirectory = "${puzzler}/validator/back";
        ExecStart = ''${pkgs.nodejs}/bin/node build/src/index.js "--env=prod"'';
        StandardOutput = "journal";
        StandardError = "journal";
        SyslogIdentifier = "puzzler";
        Restart = "on-failure";
        RestartSec = 5;
      };
    };

    puzzler-copy = {
      Unit = { Description = "Tags and uploads new puzzles"; };
      Service = {
        Type = "oneshot";
        ExecStart = "${puzzler}/bin/import-more.sh";
        WorkingDirectory = puzzler;
        Environment = "PATH=$PATH:/run/current-system/sw/bin";
      };
      Install = { WantedBy = [ "multi-user.target" ]; };
    };
  };

  systemd.user.timers.puzzler-copy-timer = {
    Unit = {
      Description = "Runs puzzler-copy nightly";
      Requires = [ "puzzler-copy.service" ];
    };
    Timer = {
      Unit = "puzzler-copy.service";
      # every night at 4am
      OnCalendar = "*-*-* 04:00:00";
    };
    Install = { WantedBy = [ "timers.target" ]; };
  };
}
