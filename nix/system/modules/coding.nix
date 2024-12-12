{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    neovim
    git
    lazygit
    gh
    gcc
    gnumake
    go
    cargo
    luarocks
    stylua
    tree-sitter
    python3
    ruby
    scala-cli
    nodejs_23
    delta
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
}
