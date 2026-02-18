{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    fishnet
  ];

  systemd.user.services.fishnet-prod =
    let
      dir = "${config.home.homeDirectory}/fishnet";
      conf = "${dir}/fishnet.ini";
      binary = "${pkgs.fishnet}/bin/fishnet";
    in
    {
      Unit = {
        Description = "Fishnet prod";
        After = [ "network-online.target" ];
      };
      Service = {
        ExecStart = "${binary} --conf ${conf} --max-backoff 3";
        KillMode = "mixed";
        WorkingDirectory = dir;
        ReadWriteDirectories = dir;
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
