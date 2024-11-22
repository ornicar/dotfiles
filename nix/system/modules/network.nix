{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ networkmanagerapplet iw ];

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 20595 52768 ];
    };
    nftables.enable = true; # the new iptables
    networkmanager.enable = true;
    stevenblack.enable = true;
  };
}
