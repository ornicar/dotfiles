{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    neovim
    git
    lazygit
    gh
    gcc
    gnumake
    nodejs_22
    go
    cargo
    luarocks
    stylua
    tree-sitter
    jdk
    python3
    ruby
    sbt
    bloop
    coursier # required by metals
    metals
    scala-cli
    corepack
    dart-sass
    delta
    redis
    ruff-lsp
    pyright
    cargo
    rustc
    rust-analyzer
    taplo # TOML language server
    marksman # markdown language server
    http-server
    meld
    ansible
  ];

  programs.java.enable = true;

  services.redis.servers."".enable = true;
}
