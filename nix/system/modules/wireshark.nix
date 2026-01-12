{ pkgs, ... }: {

  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
  };
  environment.systemPackages = with pkgs; [ wireshark-qt ];
}
