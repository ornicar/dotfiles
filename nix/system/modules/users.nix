{ ... }: {
  users.users = {
    thib = {
      isNormalUser = true;
      extraGroups = [ "wheel" "video" "nginx" "dialout" ];
      homeMode = "750"; # for nginx to read assets
    };
  };

  security.sudo = {
    execWheelOnly = true;
    wheelNeedsPassword = true;
    extraConfig = ''
      Defaults        timestamp_timeout=600
    '';
  };
}
