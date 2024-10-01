{ pkgs, ... }: {
  # more in stylix.nix
  fonts.packages = with pkgs; [
    font-awesome # installed for waybar icons
    jetbrains-mono # terminal
    # iosevka-bin
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    # (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    # (nerdfonts.override { fonts = [ "FiraMono" "JetBrainsMono" ]; })
  ];
}
