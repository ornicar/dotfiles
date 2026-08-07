{ ... }:
{
  imports = [
    ./rofi.nix
  ];
  services.cliphist = {
    enable = true;
  };
}
