{ inputs, ... }:
{
  imports = [
    inputs.hyprshell.homeModules.hyprshell
  ];
  programs.hyprshell = {
    enable = true;
    systemd.args = "-v";
    settings = {
      windows = {
        enable = true; # please dont forget to enable windows if you want to use overview or switch
        overview = {
          enable = true;
          key = "alt_o";
          modifier = "alt";
          launcher = {
            max_items = 6;
          };
        };
        switch.enable = true;
      };
    };
  };
}
