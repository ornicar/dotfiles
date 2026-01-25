{ ... }:
{
  imports = [ ../modules/hyprland.nix ];

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "$mod, space, exec, bemenu-run -H 40"
      ];
    };
  };
}
