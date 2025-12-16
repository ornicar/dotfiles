{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    firefox
    google-chrome
    # brave 
  ];

  programs.firefox = {
    enable = true;
    autoConfig = ''
      pref("key_toggleMute", 0);
    '';
  };
}
