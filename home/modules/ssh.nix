{ ... }:

{
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    extraConfig = ''
      Host crom
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
}
