{ pkgs, ... }:
{
  imports = [ ./wayland.nix ];

  environment.systemPackages = with pkgs; [
    swaylock
    swayidle
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  hardware.graphics.enable = true;

  # required for hm sway? https://nixos.wiki/wiki/Sway
  security.polkit.enable = true;

  # faster sway maybe? https://nixos.wiki/wiki/Sway
  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];
}
