# desktop PC home config
{ ... }: {
  imports = [
    ../common.nix
    ../modules/wine.nix
    ../services/disposable-email.nix
    ../services/puzzler.nix

    ./sway.nix
    ./waybar.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
