{ pkgs, ... }: {
  stylix = {
    image = pkgs.fetchurl {
      url = "https://r4.wallpaperflare.com/wallpaper/255/651/748/linux-nixos-operating-system-hd-wallpaper-1bc61c5d03e10fc9d5140b793d8cdc40.jpg";
      hash = "sha256-u7f6WqEev7GGDWtV0D6ql78kGDuWcTgLtx3gJG6iYXw=";
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

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
    };
  };
}
