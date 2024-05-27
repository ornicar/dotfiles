{ pkgs, ... }:
{
  users.users = {
    thib = {
      isNormalUser = true;
      extraGroups = [ "wheel" "video" ];
    };
  };
}
