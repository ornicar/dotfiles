{ config, ... }:
{
  systemd.user.services.fishnet-prod =
    let
      fishnet = "${config.home.homeDirectory}/fishnet";
      release = "${fishnet}/target/release";
    in
    {
      Unit = {
        Description = "Fishnet prod";
        After = [ "network-online.target" ];
      };
      Service = {
        ExecStart = "${release}/fishnet --conf ${fishnet}/fishnet.ini --auto-update";
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
