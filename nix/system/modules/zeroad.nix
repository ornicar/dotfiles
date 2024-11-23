{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ zeroad ];

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 20595 33033 ];
      allowedUDPPorts = [ 20595 33033 ];
    };
  };
}
