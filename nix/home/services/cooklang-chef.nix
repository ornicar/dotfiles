{ config, ... }: {

  systemd.user.services.cooklang-chef = let
    recipes = "${config.home.homeDirectory}/recipes";
    chef = "${config.home.homeDirectory}/.cargo/bin/chef";
    port = "9801";
  in {
    Unit = {
      Description = "Cooklang chef";
      After = [ "network-online.target" ];
    };
    Service = {
      ExecStart =
        "${chef} serve --port ${port} --host --path ${recipes} --disable-open-editor";
      WorkingDirectory = recipes;
    };
    Install = { WantedBy = [ "default.target" ]; };
  };
}
