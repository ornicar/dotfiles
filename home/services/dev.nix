{ pkgs, config, ... }:
let
  home = config.home.homeDirectory;
  bins = "/run/current-system/sw/bin";
in
{
  systemd.user.services.fishnet-local = 
    let
      fishnet = "${home}/fishnet";
      release = "${fishnet}/target/release";
    in {
    Unit = {
      Description = "Fishnet client";
      After = [ "network-online.target" ];
    };
    Service = {
      ExecStart = "${release}/fishnet --conf ${fishnet}/fishnet.ini.local.analysis";
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
  systemd.user.services.picfit = {
    Unit = {
      Description = "Picfit lila image server";
    };
    Service = {
      ExecStart = "${home}/picfit/bin/picfit -c ${home}/picfit/config.json";
      StandardOutput = "journal";
      StandardError = "journal";
      SyslogIdentifier = "picfit";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
