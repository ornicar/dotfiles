{ nixpkgs-mongodb-pin, ... }: {

  nixpkgs.overlays = [
    (final: prev: {
      mongodb-6_0 = (import nixpkgs-mongodb-pin {
        system = "x86_64-linux";
        config.allowUnfree = true;
      }).mongodb-6_0;
    })
    # (final: prev: {
    #   bloop = prev.bloop.overrideAttrs (previousAttrs: rec {
    #     version = "1.5.17";
    #     bloop-zsh = prev.fetchurl {
    #       url =
    #         "https://github.com/scalacenter/bloop/releases/download/v1.6.0/zsh-completions";
    #       sha256 = "sha256-WNMsPwBfd5EjeRbRtc06lCEVI2FVoLfrqL82OR0G7/c=";
    #     };
    #     bloop-binary = prev.fetchurl {
    #       url =
    #         "https://github.com/scalacenter/bloop/releases/download/v1.5.17/bloop-x86_64-pc-linux";
    #       sha256 = "sha256-f7ZmjDO8L3hcYkaxiwf5BBD44hBiBhNovylM4B308bI=";
    #     };
    #   });
    # })
  ];
}
