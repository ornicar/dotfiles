{ pkgs, config, ... }:
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # defaultCommand = "fd --type f'";
    defaultCommand = "rg --files --hidden";
    defaultOptions = ["--bind=ctrl-e:up" ];
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      character = {
        success_symbol = "[›](bold green)";
        error_symbol = "[›](bold red)";
      };

      git_status = {
        deleted = "✗";
        modified = "✶";
        staged = "✓";
        stashed = "≡";
      };
    };
  };
}
