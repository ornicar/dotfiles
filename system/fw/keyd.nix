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
            capslock = "overload(shift, esc)";
            # shift = "layer(shift)";
            leftmeta = "layer(control)";
            leftalt = "layer(leftalt)";
            rightalt = "layer(rightaltMaj)";
            "tab" = "overload(tabAltGr, tab)";
          };
          # caps lock acts as shift
          "capsShift:S" = {
            k = "up";
            j = "down";
            h = "left";
            l = "right";
          };
          "shift:S" = { delete = "S-insert"; };
          # left alt combines with space for enter
          "leftalt:A" = { space = "enter"; };
          # right alt acts as shift
          "rightaltMaj:S" = { };
          # tab acts as alt gr for french accents, and can do arrow keys
          "tabAltGr:G" = {
            k = "up";
            j = "down";
            h = "left";
            l = "right";
          };
        };
      };
    };
  };
}
