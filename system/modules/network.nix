{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];

  networking = {
    firewall = { enable = true; };
    nftables.enable = true; # the new iptables
    networkmanager.enable = true;
    stevenblack.enable = true;
  };
}
