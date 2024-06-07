{ ... }: {
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      cursor_blink_interval = 0;
      open_url_with = "google-chrome-stable";
    };
    shellIntegration.enableZshIntegration = true;
    keybindings = {
      "alt+p" = "paste_from_clipboard";
      "ctrl+pagedown" = "change_font_size current -1.0";
      "ctrl+pageup" = "change_font_size current +1.0";
      "ctrl+f5" = "load_config_file";
      "kitty_mod+Enter" = "launch --type=os-window --cwd=current";
    };
    extraConfig = ''
      scrollback_lines 9000
      scrollback_pager nvim -c 'setlocal nonumber nolist showtabline=0 foldcolumn=0|Man!' -c "autocmd VimEnter * normal G" -
      scrollback_pager_history_size 64
    '';
  };
}
