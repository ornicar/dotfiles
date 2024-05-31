# frame.work 16 home config
{ ... }: {
  imports = [ ../common.nix ../modules/barrier.nix ./sway.nix ./waybar.nix ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
