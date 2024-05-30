# desktop PC home config
{ inputs, lib, config, pkgs, ... }: {
  imports =
    [ ./common.nix ./services/disposable-email.nix ./services/puzzler.nix ];

  home.packages = with pkgs; [
    (wineWowPackages.full.override {
      wineRelease = "staging";
      mingwSupport = true;
    })
    winetricks
  ];

  wayland.windowManager.sway.extraConfig =
    let modifier = config.wayland.windowManager.sway.config.modifier;
    in ''
      bindsym F8 exec 'playerctl play-pause';
      bindsym F9 exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0';
      bindsym F10 exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0';
      bindsym ${modifier}+F10 exec 'screenshot.sh clipboard';
    '';

  services.swayidle = {
    enable = true;
    timeouts = let
      # http post localhost:11987/login -a CCAdmin:coolAdmin
      cooler-cookie =
        "cc=ZFgH++e8rWPQNmKMqzF5z6ElsbcUxANwzMnCEZtdyGdT2WFwlZiTNXmiObaYNjIxGh2R5tgrwQ%3D%3D";
      cooler-uid-off = "d7e75992-c2ce-473f-bbc7-0dd23c00ae07";
      cooler-uid-on = "d14d565f-c9da-403d-bf54-7476379eb798";
      crom-mode = pkgs.writeShellScript "crom-mode.sh" ''
        mode=$1
        ${pkgs.sway}/bin/swaymsg "output * power $mode" 
        if [ "$mode" = "off" ]; then uid=${cooler-uid-off}; else uid=${cooler-uid-on}; fi
        ${pkgs.curl}/bin/curl -XPOST -H "cookie: ${cooler-cookie}" "localhost:11987/modes-active/$uid"
      '';
    in [{
      timeout = 600;
      command = "${crom-mode} off";
      resumeCommand = "${crom-mode} on";
    }];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
