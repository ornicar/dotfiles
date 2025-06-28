{ config, lib, ... }:
with config.lib.stylix.colors.withHashtag; {
  # auto start
  # programs.zsh.profileExtra = ''
  #   if [ -z "$DISPLAY" ] && [ "''${XDG_VTNR:-0}" -eq 1 ]; then
  #     exec sway
  #   fi
  # '';

  programs.bemenu = { enable = true; };
  stylix.targets.bemenu.enable = false;

  gtk = { enable = true; };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    checkConfig = false;
    config = rec {
      fonts = lib.mkForce {
        names = [ "DejaVu Sans" ];
        size = 0.5;
      };
      modifier = "Mod1";
      terminal = "kitty -1";
      left = "n";
      right = "e";
      down = "h";
      up = "l";
      menu = "bemenu-run -H 40 | xargs swaymsg exec --";
      input = {
        "type:keyboard" = {
          xkb_layout = "us,us";
          xkb_variant = "colemak,";
          repeat_rate = "64";
          repeat_delay = "180";
        };
      };
      colors = let
        text = base04;
        urgent = base09;
        focused = base04;
        unfocused = base00;
        background = base00;
        indicator = base0C;
      in lib.mkForce {
        inherit background;
        urgent = {
          inherit background indicator text;
          border = urgent;
          childBorder = urgent;
        };
        focused = {
          border = focused;
          childBorder = focused;
          background = focused;
          indicator = focused;
          text = focused;
        };
        focusedInactive = {
          inherit background indicator text;
          border = unfocused;
          childBorder = unfocused;
        };
        unfocused = {
          inherit background indicator text;
          border = unfocused;
          childBorder = unfocused;
        };
        placeholder = {
          inherit background indicator text;
          border = unfocused;
          childBorder = unfocused;
        };
      };
      focus.followMouse = false;
      floating.modifier = modifier;
      keybindings = {
        "${modifier}+return" = "exec ${terminal}";
        "${modifier}+v" = "exec neovide";
        "${modifier}+q" = "kill";
        "${modifier}+shift+c" = "reload";
        "${modifier}+s" = "splith";
        "${modifier}+f" = "layout toggle tabbed split";
        "${modifier}+shift+f" = "layout toggle splitv splith";
        "F11" = "fullscreen toggle";
        # Move the focused window with the same, but add Shift
        "${modifier}+shift+${left}" = "move left";
        "${modifier}+shift+${down}" = "move down";
        "${modifier}+shift+${up}" = "move up";
        "${modifier}+shift+${right}" = "move right";
        # Ditto, with arrow keys
        "${modifier}+shift+Left" = "move left";
        "${modifier}+shift+Down" = "move down";
        "${modifier}+shift+Up" = "move up";
        "${modifier}+shift+Right" = "move right";

        "F2" = "exec 'systemctl --user restart lila'";
        "F3" = "exec 'systemctl --user restart lila-ws'";

        "${modifier}+${left}" = "focus left";
        "${modifier}+${right}" = "focus right";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+o" = "focus parent";
        "${modifier}+i" = "focus child";

        "${modifier}+shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "${modifier}+shift+r" = "mode resize";

        # "${modifier}+t" = "splitv; exec kitty; resize set height 200 px";

        # Switch to workspace
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";
        # Move focused container to workspace
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
        #
        "ctrl+f1" = "exec 'keyboard-switch-notify.sh'";
        # "ctrl+f6" = "mode gaming";
      };
      modes = {
        resize = {
          "escape" = "mode default";
          "${left}" = "resize shrink width 10 px";
          "${right}" = "resize grow width 10 px";
          "${down}" = "resize grow height 10 px";
          "${up}" = "resize shrink height 10 px";
          "shift+${left}" = "resize shrink width 300 px";
          "shift+${right}" = "resize grow width 300 px";
          "shift+${down}" = "resize grow height 300 px";
          "shift+${up}" = "resize shrink height 300 px";
        };
        # gaming = {
        #   "ctrl+f6" = "mode default";
        #   "f11" = "fullscreen toggle";
        #   # Switch to workspace
        #   "${modifier}+ctrl+1" = "workspace number 1";
        #   "${modifier}+ctrl+2" = "workspace number 2";
        #   "${modifier}+ctrl+3" = "workspace number 3";
        #   "${modifier}+ctrl+4" = "workspace number 4";
        #   "${modifier}+ctrl+5" = "workspace number 5";
        #   "${modifier}+ctrl+6" = "workspace number 6";
        #   "${modifier}+ctrl+7" = "workspace number 7";
        #   "${modifier}+ctrl+8" = "workspace number 8";
        #   "${modifier}+ctrl+9" = "workspace number 9";
        #   "${modifier}+ctrl+0" = "workspace number 10";
        # };
      };
      bars = [{
        position = "top";
        command = "waybar";
      }];
    };
    extraConfig = ''
      default_border pixel 1
      # borders, lol
      hide_edge_borders both
      titlebar_padding 1 1
      focus_follows_mouse yes

      # start some apps:
      workspace number 1
      exec kitty -1
      workspace number 2
      exec firefox
    '';
  };

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      ignore-timeout = false;
    };
  };

  # fixes:
  # Unable to connect to the compositor. If your compositor is running, check or set the WAYLAND_DISPLAY environment variable.
  systemd.user.services.swayidle.Service.Environment =
    lib.mkAfter [ "WAYLAND_DISPLAY='wayland-1'" ];
}
