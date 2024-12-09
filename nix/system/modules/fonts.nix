{ pkgs, ... }: {
  # more in stylix.nix
  fonts.packages = with pkgs; [
    font-awesome # installed for waybar icons
    jetbrains-mono # terminal
    # iosevka-bin
    nerd-fonts.jetbrains-mono
  ];
}
