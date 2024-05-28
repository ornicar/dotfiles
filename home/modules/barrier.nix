{ pkgs, config, ... }:
{
  services.barrier.client = {
    enable = false;
    enableCrypto = false;
    enableDragDrop = false;
    server = "crom";
  };
}
