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
    ruby
    sbt
    coursier # required by metals
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
    (callPackage ../packages/thibloop { })
  ];

  programs.java.enable = true;

  services.redis.servers."".enable = true;
}
