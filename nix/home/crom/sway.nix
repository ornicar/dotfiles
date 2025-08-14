{ config, lib, pkgs, ... }: {

  wayland.windowManager.sway = {
    config = let
      volumeDec = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0'";
      volumeInc = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0'";
    in {
      input = lib.mkAfter {
        # the glove is a bit too repeaty
        "type:keyboard".repeat_delay = lib.mkForce "250";
        # flat profile, no acceleration
        "type:mouse" = { accel_profile = "flat"; };
      };
      keybindings =
        let inherit (config.wayland.windowManager.sway.config) modifier menu;
        in lib.mkAfter {
          "${modifier}+space" = "exec ${menu}";
          "F8" = "exec '${pkgs.playerctl}/bin/playerctl -p spotify play-pause'";
          "F9" = volumeDec;
          "F10" = volumeInc;
          "${modifier}+F10" = "exec 'screenshot.sh clipboard'";
          "ctrl+f9" = ''exec "sleep 1; pkill -SIGUSR1 swayidle"'';
        };
      modes = {
        gaming = {
          "F9" = volumeDec;
          "F10" = volumeInc;
        };
      };
    };
  };

  services.swayidle = {
    enable = true;
    timeouts = let
      crom-mode = pkgs.writeShellScript "crom-mode.sh" ''
        mode=$1
        # hack to get the current sway socket as I've seen it be wrong once.
        export SWAYSOCK=$XDG_RUNTIME_DIR/sway-ipc.$UID.$(${pkgs.procps}/bin/pgrep -x sway).sock
        ${pkgs.sway}/bin/swaymsg "output * power $mode" 

        [[ $mode = "on" ]] && brightness="100" || brightness="0"
        ${pkgs.openrgb}/bin/openrgb -b $brightness

        # pause/resume puzzle generation
        [[ $mode = "on" ]] && SIG="STOP" || SIG="CONT"
        # only resume between 9pm and 6am
        night="yes"
        hour=$(${pkgs.coreutils}/bin/date +%H)
        [[ $''${hour#0} -gt 6 && $''${hour#0} -lt 22 ]] && night="no"
        [[ $SIG = "CONT" && $night = "no" ]] && SIG="STOP"
        echo "Puzzle generation: hour=$hour, night=$night, sending $SIG"
        for pid in $(${pkgs.procps}/bin/pgrep -u thib --full "generator.py"); do
          echo "kill -$SIG $pid"
          kill -$SIG $pid
        done
      '';
    in [{
      timeout = 420;
      command = "${crom-mode} off";
      resumeCommand = "${crom-mode} on";
    }];
  };
}
