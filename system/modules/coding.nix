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
    coursier
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
    taplo
    marksman
    dotnetPackages.MaxMindGeoIP2
  ];

  programs.java.enable = true;

  services.redis.servers."".enable = true;
}
