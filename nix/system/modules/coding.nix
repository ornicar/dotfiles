{ pkgs, inputs, ... }:
let
  pkgs-stable = import inputs.nixpkgs-stable { system = pkgs.stdenv.system; };
in
{
  environment.systemPackages = with pkgs; [
    git
    pkgs-stable.neovim
    neovide
    gh
    github-copilot-cli
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
    goaccess
    copilot-cli
    pnpm
    # esbuild
    devenv
  ];
}
