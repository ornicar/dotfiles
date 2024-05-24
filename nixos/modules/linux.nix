{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    fzf
    fd
    jq
    bat
    httpie
    mosh
  ];
}
