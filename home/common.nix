{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/neovim
    ./modules/cli.nix
    ./modules/coding.nix
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/lazygit.nix
    ./modules/ssh.nix
    ./modules/sway.nix
    ./modules/waybar.nix
    ./modules/zsh.nix
    ./services/bloop.nix
    ./services/lila.nix
    # ./services/gammarelay.nix
  ];

  home = rec {
    username = "thib";
    homeDirectory = "/home/${username}";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
