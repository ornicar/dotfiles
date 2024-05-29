{ pkgs, config, ... }: {
  systemd.user.services.fishnet-local = let
    fishnet = "${config.home.homeDirectory}/fishnet";
    release = "${fishnet}/target/release";
  in {
    Unit = {
      Description = "Fishnet client";
      After = [ "network-online.target" ];
    };
    Service = {
      ExecStart =
        "${release}/fishnet --conf ${fishnet}/fishnet.ini.local.analysis";
      KillMode = "mixed";
      WorkingDirectory = release;
      ReadWriteDirectories = release;
      Nice = 19;
      PrivateTmp = true;
      DevicePolicy = "closed";
      ProtectSystem = "full";
    };
    Install = { WantedBy = [ "default.target" ]; };
  };
}
