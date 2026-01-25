{ ... }:
{
  imports = [
    ../modules/hyprland.nix
  ];
  wayland.windowManager.hyprland = {
    bind = [
      "$mod, space, exec, bemenu-run -H 40"
    ];
  };
}
