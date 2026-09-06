{ pkgs, lib, ... }:
{

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi # optional AMD hardware acceleration
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  programs.zsh.shellAliases = lib.mkAfter {
    streamvoice = "google-chrome-stable --user-data-dir=/home/thib/stream-voice/chrome-voice-data-dir --app=file:///home/thib/stream-voice/index.html &";
    streamtv = "google-chrome-stable --user-data-dir=/home/thib/stream-voice/chrome-tv-data-dir --app=https://lichess.org/tv &";
    streamyt = "google-chrome-stable --user-data-dir=/home/thib/stream-voice/chrome-tv-data-dir --app=https://youtube.com &";
  };
}
