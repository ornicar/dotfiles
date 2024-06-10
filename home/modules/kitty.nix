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
    extraConfig = let
      kitty-remote = ''
        # the following is for kitty-remote https://github.com/mikesmithgh/kitty-scrollback.nvim?tab=readme-ov-file#%EF%B8%8F-setup
        allow_remote_control socket-only 
        listen_on unix:/tmp/kitty
        shell_integration enabled
        # kitty-scrollback.nvim Kitten alias
        action_alias kitty_scrollback_nvim kitten /home/thib/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py
        # Browse scrollback buffer in nvim
        map kitty_mod+h kitty_scrollback_nvim
        # Browse output of the last shell command in nvim
        map kitty_mod+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output
        # Show clicked command output in nvim
        mouse_map ctrl+shift+right press ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output
      '';
    in ''
      scrollback_lines 9000
      scrollback_pager_history_size 32

      ${kitty-remote}
    '';
  };
}
