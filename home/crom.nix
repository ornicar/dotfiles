# desktop PC home config
{ inputs, lib, config, pkgs, ... }: 
{
  imports = [
    ./common.nix

    ./services/disposable-email.nix
    ./services/puzzler.nix
  ];

  wayland.windowManager.sway.extraConfig = let
    modifier = config.wayland.windowManager.sway.config.modifier;
  in ''
bindsym F8 exec 'playerctl play-pause';
bindsym F9 exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0';
bindsym F10 exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0';
bindsym ${modifier}+F10 exec 'screenshot.sh clipboard';
'';

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
