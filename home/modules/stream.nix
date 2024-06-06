{ pkgs, lib, ... }: {

  programs.obs-studio.enable = true;

  programs.zsh.shellAliases = lib.mkAfter {
    streamvoice =
      "google-chrome-stable --user-data-dir=/home/thib/stream-voice/chrome-voice-data-dir --app=file:///home/thib/stream-voice/index.html &";
    streamtv =
      "google-chrome-stable --user-data-dir=/home/thib/stream-voice/chrome-tv-data-dir --app=https://lichess.org/tv &";
  };

  home.packages = [ pkgs.showmethekey ];

  wayland.windowManager.sway.extraConfig = lib.mkAfter ''
    for_window [title="Floating Window - Show Me The Key"] floating enable, sticky enable, resize set width 400px height 100px, move position 2000px 1000px

    for_window [title="www.twitch.tv/ornicar2 voice"] floating enable, resize set width 600px height 54px, move position 2900px 2118px
  '';
}
