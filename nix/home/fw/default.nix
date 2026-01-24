# frame.work 16 home config
{ ... }:
{
  imports = [
    ../common.nix
    ../modules/easyeffects.nix
    ./sway.nix
    ./waybar.nix
    ../modules/wine.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
