# frame.work 16 home config
{ ... }: {
  imports = [ ../common.nix ./sway.nix ./waybar.nix ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
