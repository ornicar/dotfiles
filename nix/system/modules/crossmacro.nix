{ pkgs, inputs, ... }:
{
  # environment.systemPackages = with pkgs; [
  #   crossmacro
  # ];
  services.crossmacro = {
    enable = true;
    users = [ "thib" ];
  };
  users.users = {
    thib = {
      extraGroups = [ "crossmacro" ];
    };
  };
}
