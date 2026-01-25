{ pkgs, ... }:
{

  console.keyMap = "colemak";

  environment.systemPackages = with pkgs; [
    keyd
    wev
  ];
}
