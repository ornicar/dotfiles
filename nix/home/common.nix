{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  options.custom.darkTheme = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to use the dark theme";
  };

  imports = [
    ./modules/cli.nix
    ./modules/scala.nix
    ./modules/lila.nix
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/lazygit.nix
    ./modules/mongodb.nix
    ./modules/neovim.nix
    # ./modules/zed.nix
    ./modules/ssh.nix
    ./modules/xdg.nix
    ./modules/zsh.nix
    ./modules/mpv.nix
    ./modules/keyring.nix
    # ./modules/lan-mouse.nix

    ./services/lila.nix
    # ./services/lila-http.nix
    # ./services/fishnet-local.nix
    # ./services/gammarelay.nix
  ];

  config = {
    custom.darkTheme = osConfig.custom.darkTheme;

    home = rec {
      username = "thib";
      homeDirectory = "/home/${username}";
      file.".local/bin".source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/scripts";
    };
    home.pointerCursor.enable = true;

    gtk.theme = lib.mkForce {
      name = if config.custom.darkTheme then "adw-gtk3-dark" else "adw-gtk3";
      package = pkgs.adw-gtk3;
    };

    dconf.settings."org/gnome/desktop/interface".color-scheme = lib.mkForce (
      if config.custom.darkTheme then "prefer-dark" else "default"
    );

    programs.home-manager.enable = true;

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";
  };
}
