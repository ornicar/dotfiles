{ pkgs, ... }: {
  users.users = {
    thib = {
      isNormalUser = true;
      extraGroups = [ "wheel" "video" ];
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
