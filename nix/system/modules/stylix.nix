{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {

    enable = true;

    # https://tinted-theming.github.io/base16-gallery/
    base16Scheme = let theme = "catppuccin-mocha";
    in "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

    override = { base00 = "#1f1e22"; };

    image = ../../home/wallpaper/fsm1.jpg;

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
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 14;
        desktop = 14;
        popups = 15;
        terminal = 15;
      };
    };

    opacity = {
      terminal = 0.9;
      popups = 0.9;
      desktop = 0.9;
      applications = 0.9;
    };
  };
}
