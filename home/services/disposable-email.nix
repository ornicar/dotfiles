{ config, pkgs, ... }: {
  systemd.user.services.disposable = let home = config.home.homeDirectory;
  in {
    Unit = {
      Description = "Updates and pushes disposable emails";
      After = [ "ssh-agent.service" ];
    };
    Install = { WantedBy = [ "multi-user.target" ]; };
    Service = {
      ExecStart = "${home}/disposable/update.sh";
      Type = "oneshot";
      WorkingDirectory = "${home}/disposable";
      Environment = "SSH_AUTH_SOCK=%t/ssh-agent.socket";
      ExecStartPre = "${pkgs.openssh}/bin/ssh-add /home/thib/.ssh/id_nokey";
    };
  };
  systemd.user.timers.disposable-timer = {
    Unit = {
      Description = "Runs disposable nightly";
      Requires = [ "disposable.service" ];
    };
    Timer = {
      Unit = "disposable.service";
      # every night at 1am
      OnCalendar = "*-*-* 01:00:00";
    };
    Install = { WantedBy = [ "timers.target" ]; };
  };
}
