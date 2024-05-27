{ pkgs, config, ... }: {
  stylix = {
    image = config.lib.stylix.pixel "base00";
    # https://github.com/tinted-theming/base16-schemes
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark.yaml";

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
        desktop = 17;
        popups = 17;
        terminal = 17;
      };
    };
  };
}
