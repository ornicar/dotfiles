{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    git
    lazygit
    gcc
    gnumake
    nodejs
    gh
    fzf
    fd
    go
    cargo
    luarocks
    tree-sitter
    jdk
    python3
    bat
    httpie
    sbt
    bloop
    coursier
    corepack
    dart-sass
    delta
    mosh
    mongosh
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  services.bloop = {
    install = true;
    extraOptions = [
      "-J-Xmx14G"
    ];
  };
}
