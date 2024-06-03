{ inputs, pkgs, ... }: {
  imports = [ inputs.lan-mouse.homeManagerModules.default ];
  programs.lan-mouse = {
    enable = true;
    systemd = true;
    # package = inputs.lan-mouse.packages.${pkgs.stdenv.hostPlatform.system}.default
    # Optional configuration in nix syntax, see config.toml for available options
    settings = let
      # we can't use any ${pkgs} proper path,
      # because it also runs commands on the remote machine
      shareClipboard = dest:
        "wl-paste --no-newline | ssh ${dest} -i .ssh/id_home_nokey env WAYLAND_DISPLAY='wayland-1' wl-copy";
    in {
      release_bind = [ "KeyLeftCtrl" "Key5" ];
      port = 4242;
      frontend = "cli";
      right = {
        hostname = "crom";
        activate_on_startup = true;
        enter_hook = shareClipboard "crom";
        ips = [ "192.168.1.2" ];
      };
      left = {
        hostname = "fw";
        activate_on_startup = true;
        enter_hook = shareClipboard "fw";
        ips = [ "192.168.1.3" ];
      };
    };
  };

  systemd.user.services.lan-mouse.Service.Environment =
    "PATH=$PATH:/run/current-system/sw/bin";

  programs.waybar.settings.mainBar."custom/lan-mouse" = let
    systemctl = "${pkgs.systemd}/bin/systemctl --user";
    service = "lan-mouse.service";
  in {
    interval = 5;
    exec = pkgs.writeShellScript "lan-mouse-check" ''
      if ${systemctl} is-active --quiet ${service}
      then echo "󰍽 ON"
      else echo "󰍾"
      fi
    '';
    format = "{}";
    tooltip-format = "LAN Mouse";
    on-click = pkgs.writeShellScript "lan-mouse-toggle" ''
      if ${systemctl} is-active --quiet ${service}
      then ${systemctl} stop ${service}
      else ${systemctl} start ${service}
      fi
    '';
  };
}
