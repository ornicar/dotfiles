{ ... }: {
  services.keyd = {
    enable = true;
    keyboards = {
      glove = {
        ids = [ "16c0:27db" ];
        settings = {
          main = { leftcontrol = "layer(leftcontrol)"; };
          "leftcontrol:C" = {
            j = "down";
            k = "up";
            comma = "C-tab";
            m = "C-S-tab";
            # h = "left";
            # u = "right"; ctrl+l focuses the address bar
          };
        };
      };
      kone = {
        ids = [ "1e7d:afca" ];
        settings = {
          main = {
            # enables prev/next in zulip
            mouse1 = "A-left";
            mouse2 = "A-right";
          };
        };
      };
    };
  };
}
