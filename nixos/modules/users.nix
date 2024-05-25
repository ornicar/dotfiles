{ pkgs, ... }:
{
  users.users = {
    thib = {
      isNormalUser = true;
      extraGroups = [ "wheel" "video" ];
    };
    nixosvmtest = {
      isSystemUser = true ;
      initialPassword = "test";
      group = "nixosvmtest";
    };
  };
  users.groups.nixosvmtest = {};
}
