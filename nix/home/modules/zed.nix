{ pkgs, config, ... }:
{
  home.packages = with pkgs; [ zed-editor ];

  # Use the external dotfiles zed config for quicker hacking
  home.file.".config/zed".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/zed";
}
