{ lib, ... }:
{
  programs.ashell = {
    settings = {
      system_info = {
        temperature = {
          sensor = "k10temp Tctl";
        };
      };
    };
  };
}
