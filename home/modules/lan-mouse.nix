{ inputs, ... }: {
  imports = [ inputs.lan-mouse.homeManagerModules.default ];
  programs.lan-mouse = {
    enable = true;
    systemd = true;
    # package = inputs.lan-mouse.packages.${pkgs.stdenv.hostPlatform.system}.default
    # Optional configuration in nix syntax, see config.toml for available options
    settings = let
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

  # we can't use any ${pkgs} proper path,
  # because it also runs commands on the remote machine
  systemd.user.services.lan-mouse.Service.Environment =
    "PATH=$PATH:/run/current-system/sw/bin";
}
