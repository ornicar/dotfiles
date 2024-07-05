{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ mongodb mongodb-tools mongosh ];

  services.mongodb = { enable = true; };
}
