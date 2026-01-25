{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./wayland.nix
    ./ashell.nix
  ];

  services.hyprpaper.enable = true;
  stylix.targets.hyprland.hyprpaper.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings =
      let
        left = "N";
        right = "E";
        down = "H";
        up = "L";
        menu = "bemenu-run -H 40 | xargs swaymsg exec --";
        workspaces = lib.range 1 10;
        workspaceKey = (i: toString (if i == 10 then 0 else i));
      in
      {
        # Appearance
        general = {
          gaps_in = 8;
          gaps_out = 8;
          border_size = 2;
          # col.active_border = "rgba(${config.lib.stylix.colors.base03}ff)";
          # col.inactive_border = "rgba(${config.lib.stylix.colors.base00}ff)";
        };

        decoration = {
          rounding = 8;
          blur = {
            enabled = true;
            size = 5;
            passes = 1;
          };
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
          };
        };

        # Input
        input = {
          kb_layout = "us,us";
          kb_variant = "colemak,";
          repeat_rate = 64;
          repeat_delay = 180;
        };

        animations = {
          enabled = true;
          bezier = [
            "overshot,0.05,0.9,0.1,1.1"
            "overshot,0.13,0.99,0.29,1.0"
          ];
          animation = [
            "windows,1,7,overshot,slide"
            "border,1,10,default"
            "fade,1,10,default"
            "workspaces,1,7,overshot,slide"
          ];
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
          "$mod SHIFT, ${left}, movewindow, l"
          "$mod SHIFT, ${down}, movewindow, d"
          "$mod SHIFT, ${up}, movewindow, u"
          "$mod SHIFT, ${right}, movewindow, r"
          # "F2, exec, systemctl --user restart lila"
          # "F3, exec, systemctl --user restart lila-ws"
          "$mod, ${left}, movefocus, l"
          "$mod, ${right}, movefocus, r"
          "$mod, ${down}, movefocus, d"
          "$mod, ${up}, movefocus, u"
          # "$mod, O, focusparent"
          # "$mod, I, focuschild"
          "$mod SHIFT, minus, movetoworkspace, special"
          "$mod, minus, togglespecialworkspace"
          (map (i: "$mod, ${workspaceKey i}, workspace, ${toString i}") workspaces)
          (map (i: "$mod SHIFT, ${workspaceKey i}, movetoworkspace, ${toString i}") workspaces)
          "CTRL, F1, exec, keyboard-switch-notify.sh"
          "CTRL, F6, exec, hyprctl dispatch workspace back_and_forth"
          # Menu (bemenu-run)
          "$mod, M, exec, ${menu}"
          # Submaps
          "$mod SHIFT, R, submap, resize"
        ];

        binde = [
          "$mod, Left, resizeactive, -10 0"
          "$mod, Right, resizeactive, 10 0"
          "$mod, Down, resizeactive, 0 10"
          "$mod, Up, resizeactive, 0 -10"
        ];

        submaps = {
          "resize" = {
            settings = {
              bind = [
                "$mod SHIFT, R, submap, reset"
                # ", escape, submap, reset"
                # ", ${left}, resizeactive -10 0"
                # ", ${right}, resizeactive 10 0"
                # ", ${down}, resizeactive 0 10"
                # ", ${up}, resizeactive 0 -10"
                # ", SHIFT+${left}, resizeactive -300 0"
                # ", SHIFT+${right}, resizeactive 300 0"
                # ", SHIFT+${down}, resizeactive 0 300"
                # ", SHIFT+${up}, resizeactive 0 -300"
              ];
            };
          };
        };

        # Bar (Waybar)
        # exec-once = [ "waybar", "mako" ];
        exec-once = [
          # "kitty -1"
          "[workspace 2 silent] firefox"
          "kitty"
        ];

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };
      };
  };

  # GTK theme
  # gtk = {
  #   enable = true;
  # };

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
