{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      wl-gammarelay-rs # redshift for wayland
    ];

  systemd.user.services.gammarelay = {
    Unit = {
      Description =
        "DBus interface to control display temperature and brightness under wayland";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
    Service = {
      Type = "dbus";
      BusName = "rs.wl-gammarelay";
      ExecStart = pkgs.wl-gammarelay-rs;
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
  };
}
