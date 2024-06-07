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
      light = "${pkgs.light}/bin/light";
      api-url = "http://localhost:11987";
      uid-off = "d7e75992-c2ce-473f-bbc7-0dd23c00ae07";
      uid-on = "d14d565f-c9da-403d-bf54-7476379eb798";
      cookie-file = "/tmp/coolercontrol-cookie";
      crom-mode = pkgs.writeShellScript "crom-mode.sh" ''
        mode=$1
        ${pkgs.sway}/bin/swaymsg "output * power $mode" 
        if [ "$mode" = "off" ]; then uid=${uid-off}; else uid=${uid-on}; fi
        ${pkgs.curl}/bin/curl -XPOST -c ${cookie-file} ${api-url}/login -u CCAdmin:coolAdmin
        ${pkgs.curl}/bin/curl -XPOST -b ${cookie-file} ${api-url}/modes-active/$uid
      '';
    in [
      {
        timeout = 600;
        command = "${light} -O; ${light} -T 0.5";
        resumeCommand = "${light} -I";
      }
      {
        timeout = 630;
        command = "${crom-mode} off";
        resumeCommand = "${crom-mode} on";
      }
    ];
  };
}
