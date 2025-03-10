{ config, ... }: {

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # defaultCommand = "fd --type f'";
    defaultCommand = "rg --files --hidden";
    defaultOptions = [ "--no-mouse" "--info=inline-right" ];
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
      cpu_single_graph = true;
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

      scala = { symbol = ""; };
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
