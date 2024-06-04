{ ... }: {
  services.keyd = {
    enable = true;
    keyboards = {
      glove = {
        ids = [ "16c0:27db" ];
        settings = { shift = { tab = "S-insert"; }; };
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
