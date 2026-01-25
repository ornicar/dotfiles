{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ./wayland.nix ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      # Appearance
      general = {
        gaps_in = 8;
        gaps_out = 8;
        border_size = 2;
        # col.active_border = "rgba(${config.lib.stylix.colors.base03}ff)";
        # col.inactive_border = "rgba(${config.lib.stylix.colors.base00}ff)";
      };

      decoration = {
        rounding = 6;
        blur = {
          enabled = false;
        };
        # drop_shadow = false;
      };

      # Input
      input = {
        kb_layout = "us,us";
        kb_variant = "colemak,";
        repeat_rate = 64;
        repeat_delay = 180;
      };

      monitor = [
        ",preferred,auto,1"
      ];

      "$mod" = "ALT";

      bind = [
        "$mod, Return, exec, kitty -1"
        "$mod, V, exec, neovide"
        "$mod, Q, killactive"
        # "$mod, S, split:horizontal"
        "$mod, F, fullscreen"
        "$mod SHIFT, F, fullscreen"
        # "F11, fullscreen"
        "$mod SHIFT, N, movewindow, l"
        "$mod SHIFT, H, movewindow, d"
        "$mod SHIFT, L, movewindow, u"
        "$mod SHIFT, E, movewindow, r"
        "$mod SHIFT, Left, movewindow, l"
        "$mod SHIFT, Down, movewindow, d"
        "$mod SHIFT, Up, movewindow, u"
        "$mod SHIFT, Right, movewindow, r"
        # "F2, exec, systemctl --user restart lila"
        # "F3, exec, systemctl --user restart lila-ws"
        "$mod, N, movefocus, l"
        "$mod, E, movefocus, r"
        "$mod, H, movefocus, d"
        "$mod, L, movefocus, u"
        # "$mod, O, focusparent"
        # "$mod, I, focuschild"
        "$mod SHIFT, minus, movetoworkspace, special"
        "$mod, minus, togglespecialworkspace"
        # "$mod SHIFT, R, resize"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "CTRL, F1, exec, keyboard-switch-notify.sh"
        "CTRL, F6, exec, hyprctl dispatch workspace back_and_forth"
        # Menu (bemenu-run)
        "$mod, M, exec, bemenu-run -H 40 | xargs hyprctl dispatch exec --"
      ];

      # Bar (Waybar)
      # exec-once = [ "waybar", "mako" ];
      exec-once = [
        # "kitty -1"
        "[workspace 2 silent] firefox"
        "kitty"
        "waybar"
      ];
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${/. + ../wallpaper/horizon.jpg}" ];
      wallpaper = [ ", ${/. + ../wallpaper/horizon.jpg}" ];
    };
  };

  # Notification daemon
  # services.mako = {
  #   enable = true;
  #   settings = {
  #     default-timeout = 5000;
  #     ignore-timeout = false;
  #   };
  # };

  # GTK theme
  # gtk = {
  #   enable = true;
  # };

  # bemenu
  # programs.bemenu.enable = true;

  # hypridle (for idle management, similar to swayidle)
  # services.hypridle = {
  #   enable = true;
  #   listeners = [
  #     {
  #       timeout = 900;
  #       onTimeout = "${pkgs.light}/bin/light -O; ${pkgs.light}/bin/light -T 0.2";
  #       onResume = "${pkgs.light}/bin/light -I";
  #     }
  #     {
  #       timeout = 1200;
  #       onTimeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
  #       onResume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
  #     }
  #     {
  #       timeout = 1500;
  #       onTimeout = "${pkgs.systemd}/bin/systemctl suspend";
  #       onResume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
  #     }
  #   ];
  # };
}
