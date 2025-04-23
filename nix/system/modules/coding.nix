{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    git
    neovim
    neovide
    gh
    gh-copilot
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
    pyright
    cargo
    rustc
    rust-analyzer
    taplo # TOML language server
    marksman # markdown language server
    http-server
    meld
    ansible
    openssl
  ];
}
