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
      outer-margin = 30;
      padding = "15 20 15 20";
      border-size = 2;
      border-radius = 10;
    };
  };
}
