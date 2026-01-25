{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [ zeroad ];

  networking = {
    firewall = {
      allowedTCPPorts = [ 20595 ];
      allowedUDPPorts = [ 20595 ];
    };
  };
}
