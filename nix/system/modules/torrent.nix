{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [ transmission ];
}
