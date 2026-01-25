{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [ telegram-desktop ];
}
