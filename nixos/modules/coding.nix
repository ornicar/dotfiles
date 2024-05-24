{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    git
    lazygit
    gh
    gcc
    gnumake
    nodejs
    go
    cargo
    luarocks
    tree-sitter
    jdk
    python3
    sbt
    bloop
    coursier
    corepack
    dart-sass
    delta
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
