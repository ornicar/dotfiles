{ ... }: {
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./boot.nix
    ./coding.nix
    ./fonts.nix
    ./keyboard.nix
    ./linux.nix
    ./locale.nix
    ./mongodb.nix
    ./network.nix
    ./nginx.nix
    ./nix.nix
    ./overlay.nix
    ./packages.nix
    ./python.nix
    ./shell.nix
    ./sound.nix
    ./stylix.nix
    ./sway.nix
    ./users.nix
  ];

  services.dbus.enable = true;
}
