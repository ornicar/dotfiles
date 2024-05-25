{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/cli.nix
    ./modules/coding.nix
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/lazygit.nix
    ./modules/ssh.nix
    ./modules/sway.nix
    ./modules/waybar.nix
    ./modules/zsh.nix
    ./services/dev.nix
    ./services/lila.nix
  ];

  programs.bemenu = {
    enable = true;
  };
  programs.btop = {
    enable = true;
    settings = {
      proc_per_core = true;
      update_ms = 1000;
    };
  };

  home = {
    username = "thib";
    homeDirectory = "/home/thib";
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
