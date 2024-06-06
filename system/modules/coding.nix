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
    stylua
    tree-sitter
    jdk
    python3
    sbt
    coursier # required by metals
    scala-cli
    corepack
    dart-sass
    delta
    redis
    bloop
    ruff-lsp
    pyright
    cargo
    rustc
    rust-analyzer
    taplo # TOML language server
    marksman # markdown language server
    http-server
  ];

  programs.java.enable = true;

  services.redis.servers."".enable = true;
}
