{ config, ... }: {
  systemd.user.services = let
    home = config.home.homeDirectory;
    puzzler = "${home}/lichess-puzzler";
    bins = "/run/current-system/sw/bin";
  in {
    puzzler = {
      Unit = {
        Description = "Puzzler validator backend";
        After = [ "mongodb.service" ];
      };
      Install = { WantedBy = [ "default.target" ]; };
      Service = {
        WorkingDirectory = "${puzzler}/validator/back";
        ExecStart = ''${bins}/node build/src/index.js "--env=prod"'';
        StandardOutput = "journal";
        StandardError = "journal";
        SyslogIdentifier = "puzzler";
      };
    };

    puzzler-copy = {
      Unit = { Description = "Tags and uploads new puzzles"; };
      Service = {
        Type = "oneshot";
        ExecStart = "${puzzler}/bin/import-more.sh";
        WorkingDirectory = puzzler;
        Environment = "SSH_AUTH_SOCK=%t/ssh-agent.socket";
        ExecStartPre = "${bins}/ssh-add ${home}/.ssh/id_nokey";
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
