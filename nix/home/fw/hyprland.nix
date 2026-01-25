{ ... }:
{
  imports = [
    ../modules/hyprland.nix
  ];
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "$mod, equal, exec, bemenu-run -H 40"
      ];
    };
  };
}
