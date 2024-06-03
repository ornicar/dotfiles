{ ... }: {
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          # to view key names:
          # sudo keyd -m
          main = {
            capslock = "overload(arrows, esc)";
            shift = "layer(shift)";
            leftmeta = "layer(control)";
            rightalt = "layer(rightaltMaj)";
          };
          "arrows" = {
            k = "up";
            j = "down";
            h = "left";
            l = "right";
          };
          "shift:S" = { delete = "S-insert"; };
          "rightaltMaj:S" = { space = "enter"; };
        };
      };
    };
  };
}
