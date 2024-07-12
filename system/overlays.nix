{ nixpkgs-mongodb-pin, ... }: {

  nixpkgs.overlays = [
    (final: prev: {
      mongodb-6_0 = (import nixpkgs-mongodb-pin {
        system = "x86_64-linux";
        config.allowUnfree = true;
      }).mongodb-6_0;
    })
    # (final: prev: {
    #   bloop = prev.bloop.overrideAttrs (previousAttrs: {
    #     version = "1-thib";
    #     bloop-binary = prev.fetchurl {
    #       url =
    #         "https://github.com/scalacenter/bloop/releases/download/v1.1.1/bloop-x86_64-pc-linux";
    #       sha256 = "sha256-f7ZmjDO8L3hcYkaxiwf5BBD44hBiBhNovylM4B308bI=";
    #     };
    #   });
    # })
  ];
}
