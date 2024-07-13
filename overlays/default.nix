{ inputs, ... }: {

  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {

    mongodb-6_0 = (import inputs.nixpkgs-mongodb-pin {
      system = final.system;
      config.allowUnfree = true;
    }).mongodb-6_0;

    # bloop = prev.bloop.overrideAttrs (previousAttrs: {
    #   version = "1.6.0-3";
    #   bloop-binary = prev.fetchurl {
    #     url = "http://192.168.1.3:8080/bloop-1.6.0-thib";
    #     sha256 = "sha256-f7ZmjDO8L3hcYkaxiwf5BBD44hBiBhNovylM4B308bI=";
    #   };
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
