{ pkgs, inputs, ... }:
{
  # environment.systemPackages = with pkgs; [
  #   crossmacro
  # ];
  services.crossmacro.enable = true;
}
