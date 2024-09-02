{ inputs, ... }: {

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {

    # Because mongod takes one hour to recompile on each minor version upgrade
    mongodb-6_0 = (import inputs.nixpkgs-mongodb-pin {
      system = final.system;
      config.allowUnfree = true;
    }).mongodb-6_0;

    # hyprpaper build is broken
    hyprpaper = (import inputs.nixpkgs-master {
      system = final.system;
      config.allowUnfree = true;
    }).hyprpaper;

    bloop = prev.bloop.overrideAttrs (oldAttrs: rec {
      version = "2.0.0";
      bloop-binary = prev.fetchurl {
        url =
          "https://github.com/scalacenter/bloop/releases/download/v${version}/bloop-${oldAttrs.platform}";
        sha256 = if prev.stdenv.isLinux && prev.stdenv.isx86_64 then
          "sha256-SnDXAkNu//Dn24FaQcACEBEJODlrhvpQ8uNbge99nGA="
        else if prev.stdenv.isDarwin && prev.stdenv.isx86_64 then
          "sha256-MfenrNbL1UBC4t/0w9MTDI+kz2HKv7xJcmA57qBbMFw="
        else
          throw "unsupported platform";
      };
      installPhase = ''
        runHook preInstall

        install -D -m 0755 ${bloop-binary} $out/.bloop-wrapped

        makeWrapper $out/.bloop-wrapped $out/bin/bloop

        #Install completions
        installShellCompletion --name bloop --bash ${oldAttrs.bloop-bash}
        installShellCompletion --name _bloop --zsh ${oldAttrs.bloop-zsh}
        installShellCompletion --name bloop.fish --fish ${oldAttrs.bloop-fish}

        runHook postInstall
      '';
    });

    #   stockfish = let
    #     arch = "x86-64-bmi2";
    #     # see src/evaluate.h for nnue names
    #     nnueBigFile = "nn-e8bac1c07a5a.nnue";
    #     nnueSmallFile = "nn-37f18f62d772.nnue";
    #     nnueBig = prev.fetchurl {
    #       name = nnueBigFile;
    #       url = "https://tests.stockfishchess.org/api/nn/${nnueBigFile}";
    #       sha256 = "sha256-6LrBwHpa6YDPu39gqsi62fGp32QUwakr+y5E6Apk3eg=";
    #     };
    #     nnueSmall = prev.fetchurl {
    #       name = nnueSmallFile;
    #       url = "https://tests.stockfishchess.org/api/nn/${nnueSmallFile}";
    #       sha256 = "sha256-N/GPYtdy8xB+HWqso4mMEww8hvKrY+ZVX7vKIGNaiZ0=";
    #     };
    #   in prev.stockfish.overrideAttrs (previousAttrs: {
    #     version = "16.1-thib";
    #     src = prev.fetchFromGitHub {
    #       owner = "official-stockfish";
    #       repo = "Stockfish";
    #       rev = "stockfish-dev-20240715-e443b245";
    #       sha256 = "sha256-DeltJ2a0HmCn5zQL5HAJvQDNhELtNhH8xrOOzlMMt9M=";
    #     };
    #     postUnpack = ''
    #       sourceRoot+=/src
    #       echo "Using NNUE big: ${nnueBig}"
    #       cp "${nnueBig}" "$sourceRoot/${nnueBigFile}"
    #       echo "Using NNUE small: ${nnueSmall}"
    #       cp "${nnueSmall}" "$sourceRoot/${nnueSmallFile}"
    #     '';
    #     makeFlags = [
    #       "PREFIX=$(out)"
    #       "ARCH=${arch}"
    #       "CXX=${prev.stdenv.cc.targetPrefix}c++"
    #     ];
    #     buildFlags = [ "profile-build" ];
    #   });
  };
}
