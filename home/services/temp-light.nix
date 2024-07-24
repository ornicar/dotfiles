{ pkgs, config, ... }: {

  systemd.user.services.thib-temp-light = let
    home = config.home.homeDirectory;
    script = "${home}/dotfiles/scripts/temp-light.py";
  in {
    Unit = {
      Description = "thib-coolercontrol";
      Wants = [ "coolercontrold.service" ];
    };
    Service = { ExecStart = "${script}"; };
    Install = { WantedBy = [ "multi-user.target" ]; };
  };
}
