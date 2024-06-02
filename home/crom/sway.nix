{ config, lib, pkgs, ... }: {

  wayland.windowManager.sway.config.keybindings =
    let modifier = config.wayland.windowManager.sway.config.modifier;
    in lib.mkAfter {
      "F8" = "exec 'playerctl play-pause'";
      "F9" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0'";
      "F10" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0'";
      "${modifier}+F10" = "exec 'screenshot.sh clipboard'";
    };

  services.swayidle = {
    enable = true;
    timeouts = let
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
    in [{
      timeout = 600;
      command = "${crom-mode} off";
      resumeCommand = "${crom-mode} on";
    }];
  };
}
