{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    neovim
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
    coursier
    corepack
    dart-sass
    delta
    mongosh
  ];

  services.bloop = {
    install = true;
    extraOptions = [
      "-J-Xmx14G"
    ];
  };
}
