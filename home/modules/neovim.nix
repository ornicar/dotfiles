# The idea is to symlink dotfiles/nvim into .config/nvim,
# because I don't want nix to manage my nvim config. LazyVim does it.
# Then we write a dotfiles/nvim/init.lua that points to nix managed treesitter parsers.
{ pkgs, config, ... }:
let

  treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.comment
    p.css
    p.dockerfile
    p.gitattributes
    p.gitignore
    p.git_config
    p.go
    p.gomod
    p.gowork
    p.hcl
    p.javascript
    p.jq
    p.json
    p.json5
    p.jsonc
    p.lua
    p.make
    p.markdown
    p.nix
    p.python
    p.rust
    p.scala
    p.toml
    p.typescript
    p.vue
    p.yaml
  ]);

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };
in {
  home.packages = with pkgs; [
    lua-language-server
    prettierd
    shfmt
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-json-languageserver
  ];

  # Use the external dotfiles nvim config for quicker hacking
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/nvim";

  # Import the nix managed treesitter parsers into the nvim boot script
  home.file."dotfiles/nvim/init.lua".text = ''
    vim.opt.runtimepath:append("${treesitter-parsers}")
    require("config.init")
  '';

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
  };
}
