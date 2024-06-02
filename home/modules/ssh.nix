{ ... }:

{
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    extraConfig = ''
      Host fw
        HostName 192.168.1.3
        User thib
      Host crom
        HostName 192.168.1.2
        User thib
      Host crom-pub
        HostName 82.64.134.116
        User thib
      Host crom-forward
        HostName 82.64.134.116
        User thib
        LocalForward 27017 localhost:27017
        LocalForward 9663 localhost:9663
        LocalForward 9664 localhost:9664
      Host manta
        HostName manta.lichess.ovh
        User root
      Host kaiju
        HostName kaiju.lichess.ovh
        User root
      Host rodan
        HostName rodan.lichess.ovh
        User root
      Host snafu
        HostName 141.94.96.141
        User root
    '';
  };

  services.ssh-agent.enable = true;

  home.file.".ssh/authorized_keys".text = ''
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGSPqUrPj2kMuJ70tTnAxtQ2jhcklh2s0br9Vt7mm4XW thib@lichess
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBf8j+Z9iVPdqMqXDHMZduYemty7GKm2I/DFyM5Jghp6 thib@home
  '';
}
