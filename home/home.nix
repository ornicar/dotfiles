# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    ./git.nix
    ./kitty.nix
    ./lazygit.nix
  ];

  programs.bemenu = {
    enable = true;
  };
  programs.eza = {
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

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
