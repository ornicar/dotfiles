{ ... }: {
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        # 32ac:0012 Framework Laptop 16 Keyboard Module
        ids = [ "32ac:012" ];
        settings = {
          # to view key names:
          # sudo keyd -m
          main = {
            shift = "layer(shiftAltGr)";
            capslock = "layer(capsShift)";
            leftmeta = "layer(control)";
            leftalt = "layer(leftalt)";
            rightalt = "layer(rightaltMaj)";
            "tab" = "layerm(tab, esc)";
          };
          # both shift keys act as alt gr for french accents
          "shiftAltGr:G" = { };
          # # caps lock acts as shift
          "capsShift:S" = { delete = "S-insert"; };
          # left alt combines with space for enter
          "leftalt:A" = { space = "enter"; };
          # right alt acts as shift
          "rightaltMaj:S" = { };
          # tab acts as escape ands enters a mode where hjkl are arrow keys
          "tab" = {
            k = "up";
            j = "down";
            h = "left";
            l = "right";
            space = "tab";
          };
        };
      };
    };
  };
}
