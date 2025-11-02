{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ networkmanagerapplet iw ];

  networking = {
    firewall = {
      enable = true;
      extraPackages = with pkgs; [ ipset ];
    };
    nftables.enable = true; # the new iptables
    networkmanager.enable = true;
    stevenblack.enable = true;
    # networkmanager.dns = "none";
    useDHCP = false;
    dhcpcd.enable = false;
    nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" ];
  };
}
