# desktop PC home config
{ inputs, lib, config, pkgs, ... }: 
{
  imports = [
    ./common.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
