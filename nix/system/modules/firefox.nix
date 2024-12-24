{ ... }:

{
  programs.firefox = {
    enable = true;
    autoConfig = ''
      pref("key_toggleMute", 0);
    '';
  };
}
