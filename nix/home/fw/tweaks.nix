{ ... }:
{
  home.file.".config/neovide/config.toml".text = ''
    tabs = false
    fork = true
    startup-message-capture = false # for nvim noice

    [font]
    normal = ["JetBrains Mono"]
    size = 15.0
  '';
}
