{ pkgs, ... }: {

  console.keyMap = "colemak";

  environment.systemPackages = with pkgs; [
    keyd
    wev
  ];

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          # to view key names:
          # sudo keyd -m
          main = {
            capslock = "overload(control, esc)";
            insert = "S-insert";
            leftmeta = "leftcontrol";
            sysrq = "leftcontrol";
            rightalt = "layer(rightalt)";
          };
          "rightalt:G" = {
            f = "enter";
          };
        };
      };
    };
  };
}
