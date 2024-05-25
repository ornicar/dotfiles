{ pkgs, config, ... }:
let
  home = config.home.homeDirectory;
in
{
  systemd.user.services.fishnet-prod =
    let
      fishnet = "${home}/fishnet";
      release = "${fishnet}/target/release";
    in {
    Unit = {
      Description = "Fishnet prod";
      After = [ "network-online.target" ];
    };
    Service = {
      ExecStart = "${release}/fishnet --conf ${fishnet}/fishnet.ini";
      KillMode = "mixed";
      WorkingDirectory = release;
      ReadWriteDirectories = release;
      Nice = 19;
      PrivateTmp = true;
      DevicePolicy = "closed";
      ProtectSystem = "full";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
