{ pkgs, inputs, ... }:
{
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
