{ pkgs, config, inputs, ... }: {
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    image = config.lib.stylix.pixel "base00";
    # https://tinted-theming.github.io/base16-gallery/
    # catppuccin-mocha tokyo-dark
    # #231f20
    base16Scheme = let theme = "catppuccin-mocha";
    in "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

    override = { base00 = "#1e1e22"; };

    fonts = rec {
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      serif = sansSerif;

      monospace = {
        package = pkgs.fira-code;
        name = "Fira Code";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 17;
        desktop = 15;
        popups = 17;
        terminal = 17;
      };
    };
  };
}
