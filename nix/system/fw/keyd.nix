{ ... }:
{
  # very personal configuration for colemak and weak pinkies
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        # 32ac:0012 Framework Laptop 16 Keyboard Module
        ids = [ "32ac:0012" ];
        settings = {
          # to view key names:
          # sudo keyd -m
          main = {
            shift = "oneshot(shiftAltGr)";
            capslock = "layer(capsShift)";
            leftmeta = "layer(leftcontrol)";
            leftalt = "layer(leftalt)";
            rightalt = "layer(rightaltMaj)";
            # tab acts as escape and can do nothing else because:
            # - we want escape on keydown, not keyup
            # - we don't want to escape before doing something else
            tab = "esc";
          };
          "leftcontrol:C" = {
            j = "down";
            k = "up";
            comma = "C-tab";
            m = "C-S-tab";
            # h = "left";
            # u = "right"; ctrl+l focuses the address bar
          };
          # both shift keys act as alt gr for french accents
          "shiftAltGr:G" = { };
          # caps lock acts as shift
          "capsShift:S" = {
            delete = "S-insert";
            space = "tab";
          };
          # left alt combines with space for enter
          "leftalt:A" = {
            space = "enter";
          };
          # right alt acts as shift
          "rightaltMaj:S" = {
            space = "S-tab";
          };
        };
      };
    };
  };
}
