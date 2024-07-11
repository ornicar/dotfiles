{ config, lib, pkgs, ... }: {

  wayland.windowManager.sway.config.keybindings =
    let inherit (config.wayland.windowManager.sway.config) modifier menu;
    in lib.mkAfter {
      "${modifier}+space" = "exec ${menu}";
      "F8" = "exec '${pkgs.playerctl}/bin/playerctl -p spotify play-pause'";
      "F9" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0'";
      "F10" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0'";
      "${modifier}+F10" = "exec 'screenshot.sh clipboard'";
      "ctrl+f9" = ''exec "sleep 1; pkill -SIGUSR1 swayidle"'';
    };

  # the glove is a bit too repeaty
  wayland.windowManager.sway.config.input."type:keyboard".repeat_delay =
    lib.mkForce "250";

  services.swayidle = {
    enable = true;
    timeouts = let
      api-url = "http://localhost:11987";
      uid-off = "d7e75992-c2ce-473f-bbc7-0dd23c00ae07";
      # uid-on = "d14d565f-c9da-403d-bf54-7476379eb798";
      uid-on = "f9194efe-a828-4672-845b-21800f0013f0"; # summer
      cookie-file = "/tmp/coolercontrol-cookie";
      crom-mode = pkgs.writeShellScript "crom-mode.sh" ''
        mode=$1
        # hack to get the current sway socket as I've seen it be wrong once.
        export SWAYSOCK=$XDG_RUNTIME_DIR/sway-ipc.$UID.$(${pkgs.procps}/bin/pgrep -x sway).sock
        ${pkgs.sway}/bin/swaymsg "output * power $mode" 

        # and now coolercontrol
        # ${pkgs.coreutils}/bin/sleep 0
        if [ "$mode" = "off" ]; then uid=${uid-off}; else uid=${uid-on}; fi
        ${pkgs.curl}/bin/curl --silent -XPOST -c ${cookie-file} ${api-url}/login -u CCAdmin:coolAdmin
        ${pkgs.curl}/bin/curl --silent -XPOST -b ${cookie-file} ${api-url}/modes-active/$uid
      '';
    in [{
      timeout = 600;
      command = "${crom-mode} off";
      resumeCommand = "${crom-mode} on";
    }];
  };
}
