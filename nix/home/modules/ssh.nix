{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        forwardAgent = true;
      };
    };
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
      Host github-nokey
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_nokey
    '';
  };

  services.ssh-agent.enable = true;
}
