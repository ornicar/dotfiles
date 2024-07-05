{ nixpkgs-mongodb-pin, ... }: {

  nixpkgs.overlays = [
    (self: super: {
      mongodb-6_0 = (import nixpkgs-mongodb-pin {
        system = "x86_64-linux";
        config.allowUnfree = true;
      }).mongodb-6_0;
    })
  ];
}
