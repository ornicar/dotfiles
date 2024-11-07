{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ networkmanagerapplet iw ];

  networking = {
    firewall = { enable = true; };
    nftables.enable = true; # the new iptables
    networkmanager.enable = true;
    stevenblack.enable = true;
  };
}
