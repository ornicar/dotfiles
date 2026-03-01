{ pkgs, ... }:
{
  # more in stylix.nix
  fonts.packages = with pkgs; [
    # font-awesome
    jetbrains-mono # terminal
    # iosevka-bin
    nerd-fonts.jetbrains-mono
  ];
}
