{ pkgs, ... }: {

  programs.adb.enable = true;
  users.users.thib.extraGroups = [ "adbusers" ];

  environment.systemPackages = with pkgs; [ android-studio ];
}
