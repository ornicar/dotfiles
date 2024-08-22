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
    lib.mkForce "230";

  services.swayidle = {
    enable = true;
    timeouts = let
      crom-mode = pkgs.writeShellScript "crom-mode.sh" ''
        mode=$1
        # hack to get the current sway socket as I've seen it be wrong once.
        export SWAYSOCK=$XDG_RUNTIME_DIR/sway-ipc.$UID.$(${pkgs.procps}/bin/pgrep -x sway).sock
        ${pkgs.sway}/bin/swaymsg "output * power $mode" 

        [[ $mode = "on" ]] && cc="default" || cc="sleep"
        echo $cc > /tmp/coolercontrol-mode
      '';
    in [{
      timeout = 600;
      command = "${crom-mode} off";
      resumeCommand = "${crom-mode} on";
    }];
  };
}
