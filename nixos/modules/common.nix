{ ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./boot.nix
    ./coding.nix
    ./fonts.nix
    ./keyboard.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./packages.nix
    ./shell.nix
    ./sound.nix
    ./sway.nix
    ./users.nix
  ];

  services.dbus.enable = true;
}
