{ config, ... }: {
  imports = [
    ./modules/cli.nix
    ./modules/coding.nix
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/lazygit.nix
    ./modules/neovim.nix
    ./modules/ssh.nix
    ./modules/sway.nix
    ./modules/waybar.nix
    ./modules/xdg.nix
    ./modules/zsh.nix
    # ./modules/lan-mouse.nix

    ./services/bloop.nix
    ./services/lila.nix
    # ./services/gammarelay.nix
  ];

  home = rec {
    username = "thib";
    homeDirectory = "/home/${username}";
    file.".local/bin".source =
      config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/scripts";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
