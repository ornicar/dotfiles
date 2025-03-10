{ pkgs, ... }: {

  # sensors tui

  environment.systemPackages = with pkgs; [ s-tui ];

  home.file.".config/s-tui/s-tui.conf".text = "";
}
