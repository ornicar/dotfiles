{ ... }: {
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        # 16c0:27db MoErgo Glove80
        ids = [ "16c0:27db" ];
        settings = {
          main = { shift = "layer(shift)"; };
          "shift:G" = { tab = "S-insert"; };
        };
      };
    };
  };
}
