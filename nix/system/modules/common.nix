{ outputs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
  };

  imports = [
    ./boot.nix
    ./coding.nix
    ./rust.nix
    ./fonts.nix
    ./keyboard.nix
    ./linux.nix
    ./locale.nix
    ./mongodb.nix
    ./network.nix
    ./nginx.nix
    ./nix.nix
    ./packages.nix
    ./python.nix
    ./shell.nix
    ./sound.nix
    ./stylix.nix
    ./sway.nix
    ./hyprland.nix
    ./users.nix
    ./browser.nix
    ./docker.nix
    # ./visualvm.nix
    # ./wireshark.nix
    ./recipes-local-nginx.nix
    # ../modules/telegram.nix
    # ./zeroad.nix
    ./beyond-all-reason.nix
  ];

  services.dbus.enable = true;
}
