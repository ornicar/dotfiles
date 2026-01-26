{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./wayland.nix
    ./ashell.nix
  ];

  services.hyprpaper.enable = true;
  stylix.targets.hyprland.hyprpaper.enable = true;

  gtk.enable = true;

  wayland.windowManager.hyprland.plugins = [
    inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprfocus
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    systemd.enable = false; # https://wiki.nixos.org/wiki/Hyprland
    settings =
      let
        left = "N";
        right = "E";
        down = "H";
        up = "L";
        terminal = "kitty -1";
        editor = "neovide";
        menu = "bemenu-run -H 40 -p 'Run:'";
        workspaces = lib.range 1 10;
        workspaceKey = (i: toString (if i == 10 then 0 else i));
      in
      {
        general = {
          gaps_in = 5;
          gaps_out = "8, 8, 2, 8";
          border_size = 2;
          layout = "master";
        };

        master = {
          allow_small_split = true;
          mfact = 0.63;
          orientation = "right";
          new_on_active = "after";
          # new_status = "inherit";
          special_scale_factor = 0.95;
        };

        # Workspace rules
        workspace = [
          # Full screen single visible tiled window, except special workspace
          # "w[tv1] s[false], gapsout:0, gapsin:0, decorate:false, rounding:false, shadow:false"
        ];
        windowrule = [
          # "match:class firefox, no_blur on, border_size 0"
        ];

        decoration = {
          rounding = 30;
          rounding_power = 1;
          blur = {
            enabled = true;
            size = 3;
            passes = 2;
          };
          shadow = {
            enabled = true;
            range = 15;
            render_power = 4;
            color = lib.mkForce "rgba(0,0,0,0.9)";
            color_inactive = lib.mkForce "rgba(0,0,0,0.5)";
          };
        };

        # Input
        input = {
          kb_layout = "us,us";
          kb_variant = "colemak,";
          repeat_rate = 64;
          repeat_delay = 180;
          follow_mouse = 1;
        };

        monitor = [
          ",preferred,auto,1"
        ];

        "$mod" = "ALT";

        bind = [
          "$mod, Return, exec, ${terminal}"
          "$mod, V, exec, neovide"
          "$mod, Q, killactive"
          "$mod, F, fullscreenstate, 1 1"
          "$mod SHIFT, F, fullscreenstate, 3 3"
          ", F2, exec, systemctl --user restart lila"
          ", F3, exec, systemctl --user restart lila-ws"
          "$mod, ${up}, layoutmsg, swapprev noloop"
          "$mod, ${down}, layoutmsg, swapnext noloop"
          "$mod, M, layoutmsg, swapwithmaster"
          "$mod, minus, togglespecialworkspace"
          "$mod SHIFT, minus, movetoworkspace, special"
          (map (i: "$mod, ${workspaceKey i}, workspace, ${toString i}") workspaces)
          (map (i: "$mod SHIFT, ${workspaceKey i}, movetoworkspace, ${toString i}") workspaces)
          "CTRL, F9, exec, sleep 0.5; hyprctl dispatch dpms off"
          "$mod, EQUAL, exec, ${menu}"
        ];

        binde = [
          "$mod, ${right}, layoutmsg, cycleprev noloop"
          "$mod, ${left}, layoutmsg, cyclenext noloop"
          "$mod SHIFT, Left, resizeactive, -20 0"
          "$mod SHIFT, Right, resizeactive, 20 0"
          "$mod SHIFT, Down, resizeactive, 0 20"
          "$mod SHIFT, Up, resizeactive, 0 -20"
        ];

        exec-once = [
          "[workspace 1 silent] ${editor}"
          "[workspace 1 silent] ${terminal}"
          "[workspace 2 silent] firefox"
          "[workspace 3 silent] ${editor}"
          "[workspace 3 silent] ${terminal}"
          "[workspace 7 silent] spotify"
        ];

        animations = {
          enabled = true;
          bezier = [
            # NAME,          X0,   Y0,   X1,   Y1
            "easeOutQuint,   0.23, 1,    0.32, 1"
            "easeInOutCubic, 0.65, 0.05, 0.36, 1"
            "linear,         0,    0,    1,    1"
            "almostLinear,   0.5,  0.5,  0.75, 1"
            "quick,          0.15, 0,    0.1,  1"
          ];
          animation = [
            # NAME,         ONOFF, SPEED, CURVE        [STYLE]
            "global,        1,     10,    default"
            "border,        1,     5.39,  easeOutQuint"
            "windows,       1,     4.79,  easeOutQuint"
            "windowsIn,     1,     4.1,   easeOutQuint, popin 80%"
            "windowsOut,    1,     1.49,  linear,       popin 80%"
            "fadeIn,        1,     1.73,  almostLinear"
            "fadeOut,       1,     1.46,  almostLinear"
            "fade,          1,     3.03,  quick"
            "layers,        1,     3.81,  easeOutQuint"
            "layersIn,      1,     4,     easeOutQuint, fade"
            "layersOut,     1,     1.5,   linear,       fade"
            "fadeLayersIn,  1,     1.79,  almostLinear"
            "fadeLayersOut, 1,     1.39,  almostLinear"
            "workspaces,    0,     1.94,  almostLinear, fade"
            "workspacesIn,  0,     1.21,  almostLinear, fade"
            "workspacesOut, 0,     1.94,  almostLinear, fade"
            "zoomFactor,    1,     7,     quick"
          ];
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          key_press_enables_dpms = true;
        };
      };
  };

  # GTK theme
  # gtk = {
  #   enable = true;
  # };
}
