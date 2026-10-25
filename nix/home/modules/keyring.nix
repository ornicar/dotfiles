{ pkgs, ... }:
{

  services.gnome-keyring.enable = true;
  home.packages = [ pkgs.gcr_4 ]; # Provides org.gnome.keyring.SystemPrompter
}
