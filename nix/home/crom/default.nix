# desktop PC home config
{ ... }: {
  imports = [
    ../common.nix
    ../modules/stream.nix
    ../modules/wine.nix
    ../services/disposable-email.nix
    ../services/puzzler.nix
    # ../services/fishnet-prod.nix

    ./sway.nix
    ./waybar.nix
    ./s-tui.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
