{ ... }: {
  services.barrier.client = {
    enable = true;
    enableCrypto = false;
    enableDragDrop = false;
    server = "crom";
  };
}
