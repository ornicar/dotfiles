{ config, ... }: {
  # stylix gets the bright color wrongs
  stylix.targets.kitty.enable = false;

  programs.kitty = {
    enable = true;
    font = {
      inherit (config.stylix.fonts.monospace) package name;
      size = config.stylix.fonts.sizes.terminal;
    };
    settings.background_opacity = with config.stylix.opacity;
      "${builtins.toString terminal}";
    settings = {
      enable_audio_bell = false;
      cursor_blink_interval = 0;
      open_url_with = "firefox";
    };
    shellIntegration.enableZshIntegration = true;
    keybindings = {
      "alt+p" = "paste_from_clipboard";
      "ctrl+pagedown" = "change_font_size current -1.0";
      "ctrl+pageup" = "change_font_size current +1.0";
      "ctrl+f5" = "load_config_file";
      "kitty_mod+Enter" = "launch --type=os-window --cwd=current";
      "kitty_mod+\\" = "launch --type=background --cwd=current neovide";
    };
    extraConfig = let
      # stylix-generated = ''
      #   # Generated by stylix
      #   font_family JetBrains Mono
      #   font_size 16
      #
      #   # Shell integration is sourced and configured manually
      #   shell_integration no-rc
      #
      #   background_opacity 1.000000
      #   cursor_blink_interval 0
      #   enable_audio_bell no
      #   open_url_with firefox
      # '';
      scrollback = ''
        scrollback_lines 9000
        scrollback_pager_history_size 32
      '';
      remote = ''
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
      '';
      forwardMaps = ''
        # Instead of handling these at the kitty level,
        # we rewrite these events so that the shell program,
        # probably neovim, can use them.
        # https://www.reddit.com/r/neovim/comments/12hyi9t/make_scr_cscr_stab_ctab_work_in_neovim_kitty/
        map ctrl+tab                 send_text all \x1b[9;5u
        map ctrl+shift+tab           send_text all \x1b[9;6u
      '';
      theme = ''
        # The basic colors
        foreground              #cdd6f4
        background              #1f1e22
        selection_foreground    #1f1e22
        selection_background    #f5e0dc

        # Cursor colors
        cursor                  #f5e0dc
        cursor_text_color       #1f1e22

        # URL underline color when hovering with mouse
        url_color               #f5e0dc

        # Kitty window border colors
        active_border_color     #b4befe
        inactive_border_color   #6c7086
        bell_border_color       #f9e2af

        # OS Window titlebar colors
        wayland_titlebar_color system
        macos_titlebar_color system

        # Tab bar colors
        active_tab_foreground   #11111b
        active_tab_background   #cba6f7
        inactive_tab_foreground #cdd6f4
        inactive_tab_background #181825
        tab_bar_background      #11111b

        # Colors for marks (marked text in the terminal)
        mark1_foreground #1f1e22
        mark1_background #b4befe
        mark2_foreground #1f1e22
        mark2_background #cba6f7
        mark3_foreground #1f1e22
        mark3_background #74c7ec

        # The 16 terminal colors

        # black
        color0 #45475a
        color8 #585b70

        # red
        color1 #f38ba8
        color9 #f38ba8

        # green
        color2  #a6e3a1
        color10 #a6e3a1

        # yellow
        color3  #f9e2af
        color11 #f9e2af

        # blue
        color4  #89b4fa
        color12 #89b4fa

        # magenta
        color5  #f5c2e7
        color13 #f5c2e7

        # cyan
        color6  #94e2d5
        color14 #94e2d5

        # white
        color7  #bac2de
        color15 #a6adc8
      '';
    in ''
      ${scrollback}
      ${remote}
      ${forwardMaps}
      ${theme}
    '';
  };
}
