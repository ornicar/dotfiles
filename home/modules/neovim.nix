# The idea is to symlink dotfiles/nvim into .config/nvim,
# because I don't want nix to manage my nvim config. LazyVim does it.
{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    lua-language-server
    prettierd
    shfmt
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-json-languageserver
  ];

  # Use the external dotfiles nvim config for quicker hacking
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/nvim";
}
