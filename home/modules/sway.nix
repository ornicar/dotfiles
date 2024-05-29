{ config, lib, pkgs, ... }:
with config.lib.stylix.colors.withHashtag; {
  # auto start
  programs.zsh.profileExtra = ''
    if [ -z "$DISPLAY" ] && [ "''${XDG_VTNR:-0}" -eq 1 ]; then
      exec sway
    fi
  '';

  programs.bemenu = { enable = true; };

  gtk = { enable = true; };

  services.swayidle = {
    enable = true;
    timeouts = [{
      timeout = 600;
      command = ''${pkgs.sway}/bin/swaymsg "output * power off" '';
      resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * power on"'';
    }];
  };

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
      menu = "bemenu-run | xargs swaymsg exec --";
      input = {
        "type:keyboard" = {
          xkb_layout = "us,us";
          xkb_variant = "colemak,";
          repeat_rate = "56";
          repeat_delay = "180";
        };
      };
      colors = let
        text = base04;
        urgent = base09;
        focused = base0D;
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
      keybindings = lib.mkDefault {
        "${modifier}+return" = "exec ${terminal}";
        "${modifier}+space" = "exec ${menu}";
        "${modifier}+q" = "kill";
        "${modifier}+shift+c" = "reload";
        "${modifier}+s" = "splith";
        "${modifier}+f" = "layout tabbed";
        "${modifier}+shift+f" = "layout toggle split";
        "${modifier}+t" = "fullscreen toggle";
        #     # Move the focused window with the same, but add Shift
        "${modifier}+shift+${left}" = "move left";
        "${modifier}+shift+${down}" = "move down";
        "${modifier}+shift+${up}" = "move up";
        "${modifier}+shift+${right}" = "move right";
        #     # Ditto, with arrow keys
        "${modifier}+shift+Left" = "move left";
        "${modifier}+shift+Down" = "move down";
        "${modifier}+shift+Up" = "move up";
        "${modifier}+shift+Right" = "move right";

        "F2" = "exec 'systemctl --user restart lila'";

        "${modifier}+${left}" = "focus left";
        "${modifier}+${right}" = "focus right";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+o" = "focus parent";
        "${modifier}+i" = "focus child";

        "${modifier}+shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "${modifier}+shift+r" = "mode resize";

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

      # start major apps:
      workspace number 1
      exec kitty -1
      workspace number 2
      exec google-chrome-stable
      exec zulip
      exec discord
    '';
  };

  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    ignoreTimeout = false;
  };
}
