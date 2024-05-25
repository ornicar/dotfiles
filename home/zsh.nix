{ pkgs, config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "vicmd";

    shellAliases = {
      ll = "ls -l";
    };
    history = {
      size = 100000;
      save = 100000;
    };
  };
}
