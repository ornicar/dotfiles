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
      Host rubik-nokey
        HostName rubik.lichess.ovh
        User root
        IdentityFile ~/.ssh/id_nokey
      Host github-nokey
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_nokey
    '';
  };

  services.ssh-agent.enable = true;
}
