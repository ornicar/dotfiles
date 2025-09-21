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
    luarocks
    stylua
    tree-sitter
    python3
    ruby
    scala-cli
    nodejs_24
    delta
    pyright
    taplo # TOML language server
    marksman # markdown language server
    http-server
    meld
    ansible
    openssl
    fx # tui json viewer
    # android-studio
    tailwindcss
    goaccess
  ];
}
