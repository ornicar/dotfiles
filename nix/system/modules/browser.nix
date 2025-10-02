{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ brave ];

  programs.firefox = {
    enable = true;
    autoConfig = ''
      pref("key_toggleMute", 0);
    '';
  };
}
