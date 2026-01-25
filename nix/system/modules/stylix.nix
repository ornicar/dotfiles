{ pkgs, inputs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {

    enable = true;

    # https://tinted-theming.github.io/base16-gallery/
    base16Scheme =
      let
        theme = "catppuccin-mocha";
      in
      "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

    override = {
      base00 = "#000000";
    };

    image = ../../home/wallpaper/horizon.jpg;

    fonts = rec {
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      serif = sansSerif;

      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
      # monospace = {
      #   package = pkgs.fira-code;
      #   name = "Fira Code";
      # };

      # monospace = {
      #   package = pkgs.iosevka-bin;
      #   name = "Iosevka Term";
      # };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 13;
        desktop = 16;
        popups = 14;
        terminal = 13;
      };
    };

    opacity = {
      terminal = 0.85;
      popups = 0.7;
      desktop = 0.5;
      applications = 0.8;
    };

    # cursor = {
    #   name = "Numix-Cursor";
    #   package = pkgs.numix-cursor-theme;
    #   size = 32;
    # };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };
}
