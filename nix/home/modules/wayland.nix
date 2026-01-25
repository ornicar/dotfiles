{ ... }:
{
  programs.bemenu = {
    enable = true;
  };
  stylix.targets.bemenu.enable = false;

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      ignore-timeout = false;
    };
  };
}
