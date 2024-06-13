{ pkgs-mongodb, ... }: {

  environment.systemPackages = with pkgs-mongodb; [
    mongodb
    mongodb-tools
    mongosh
  ];

  services.mongodb = { enable = true; };
}
