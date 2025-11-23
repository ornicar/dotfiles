{ ... }: {
  programs.adb.enable = true;
  users.users.thib.extraGroups = [ "adbusers" ];
}
