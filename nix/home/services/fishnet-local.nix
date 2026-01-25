{ config, pkgs, ... }:
{

  systemd.user.services.fishnet-local =
    let
      fishnet-dir = "${config.home.homeDirectory}/fishnet";
    in
    {
      Unit = {
        Description = "Fishnet client";
        After = [ "network-online.target" ];
      };
      Service = {
        ExecStart = "${pkgs.fishnet}/bin/fishnet --conf ${fishnet-dir}/fishnet.ini.local.analysis";
        KillMode = "mixed";
        WorkingDirectory = fishnet-dir;
        ReadWriteDirectories = fishnet-dir;
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
