{ config, ... }: 
{
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
    ./modules/zsh.nix
    ./services/bloop.nix
    ./services/lila.nix
    # ./services/gammarelay.nix
  ];

  home = rec {
    username = "thib";
    homeDirectory = "/home/${username}";
    # symlinks to files we don't want hm to manage
    file =
      let
        dotfiles = "${homeDirectory}/dotfiles";
      in {
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/nvim";
        ".local/bin".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/scripts";
      };
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
