{ config, pkgs, ... }: {
  systemd.user.services.disposable = let home = config.home.homeDirectory;
  in {
    Unit = {
      Description = "Updates and pushes disposable emails";
      After = [ "ssh-agent.service" ];
    };
    Install = { WantedBy = [ "multi-user.target" ]; };
    Service = {
      ExecStart = pkgs.writeShellScript "disposable-update.sh" ''
        git pull origin master
        python .generate
        git add .
        git commit -m "auto update domains"
        git push
      '';
      Type = "oneshot";
      WorkingDirectory = "${home}/disposable";
      Environment = "PATH=$PATH:/run/current-system/sw/bin";
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
