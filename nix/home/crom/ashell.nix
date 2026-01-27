{ lib, ... }:
{
  programs.ashell = {
    settings = {
      system_info = {
        temperature = {
          sensor = "k10temp Tctl";
        };
      };
      media_player = {
        max_title_length = 100;
      };
    };
  };
}
