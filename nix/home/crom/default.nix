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
  ];

  programs.btop = {
    enable = true;
    settings = {
      show_battery = false;
      cpu_sensor = "k10temp/Tctl";
      custom_cpu_name = "Fuck Trump";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
