{ pkgs, ... }:
{
  users.users.thib = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
  };
}
