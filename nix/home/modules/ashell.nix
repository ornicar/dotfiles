{ ... }:
{
  programs.ashell = {
    enable = true;
    systemd.enable = true;
    settings = {
      position = "Bottom";
    };
  };
}
