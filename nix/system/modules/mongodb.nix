{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ mongodb-ce mongodb-tools mongosh ];

  services.mongodb = {
    package = pkgs.mongodb-ce;
    enable = true;
  };
}
