{ inputs, ... }: {
  imports = [ inputs.lan-mouse.homeManagerModules.default ];
  programs.lan-mouse = {
    enable = true;
    systemd = true;
    # package = inputs.lan-mouse.packages.${pkgs.stdenv.hostPlatform.system}.default
    # Optional configuration in nix syntax, see config.toml for available options
    settings = {
      release_bind = [ "KeyLeftCtrl" "Key5" ];
      port = 4242;
      frontend = "cli";
      right = {
        hostname = "crom";
        activate_on_startup = true;
      };
      left = {
        hostname = "fw";
        activate_on_startup = true;
      };
    };
  };
}
