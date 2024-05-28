{ pkgs, config, lib, ... }:
{
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
      symbol_map U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0C8,U+E0CA,U+E0CC-U+E0D2,U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E634,U+E700-U+E7C5,U+EA60-U+EBEB,U+F000-U+F2E0,U+F300-U+F32F,U+F400-U+F4A9,U+F500-U+F8FF Symbols Nerd Font Mono
    '';
  };
}
