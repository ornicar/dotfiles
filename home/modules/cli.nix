{ pkgs, config, ... }: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # defaultCommand = "fd --type f'";
    defaultCommand = "rg --files --hidden";
    defaultOptions = [ "--bind=ctrl-e:up" ];
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.bat = { enable = true; };
  # man with bat
  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };
  programs.ripgrep = { enable = true; };
  programs.btop = {
    enable = true;
    settings = {
      proc_per_core = true;
      update_ms = 1000;
    };
  };

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
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
}
