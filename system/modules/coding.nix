{ pkgs, nixpkgs-master, ... }: {

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
    redis
    nixpkgs-master.legacyPackages."${pkgs.system}".bloop
    ruff-lsp
    pyright
  ];

  programs.java.enable = true;

  services.redis.servers."".enable = true;
}
