{ ... }: {
  # for electron apps
  home.sessionVariables.DEFAULT_BROWSER = "firefox";

  xdg.mimeApps = {
    enable = true;
    defaultApplications = let browser = "firefox.desktop";
    in {
      "text/html" = [ browser ];
      "x-scheme-handler/http" = [ browser ];
      "x-scheme-handler/https" = [ browser ];
      "x-scheme-handler/about" = [ browser ];
      "x-scheme-handler/unknown" = [ browser ];
      "application/pdf" = [ "evince.desktop" browser ];

      "image/png" = [ "gthumb.desktop" ];
      "image/jpeg" = [ "gthumb.desktop" ];
      "image/gif" = [ "gthumb.desktop" ];

      "audio/mpeg" = [ "vlc.desktop" ];
      "audio/flac" = [ "vlc.desktop" ];

      "video/mp4" = [ "vlc.desktop" ];
      "video/quicktime" = [ "vlc.desktop" ];

      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];

      "text/markdown" = "nvim.desktop";
      "text/plain" = "nvim.desktop";
    };
  };
}
