{ inputs, ... }: {

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  # unstable-packages = final: _prev: {
  #   unstable = import inputs.nixpkgs-unstable {
  #     system = final.system;
  #     config.allowUnfree = true;
  #   };
  # };

  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {

    # Because mongod takes one hour to recompile on each minor version upgrade
    mongodb-7_0 = (import inputs.nixpkgs-mongodb-pin {
      system = final.system;
      config.allowUnfree = true;
    }).mongodb-7_0;

    # Get latest bloop
    # bloop = (import inputs.nixpkgs-master {
    #   system = final.system;
    #   config.allowunfree = true;
    # }).bloop;

    stockfish = let
      version = "17";
      arch = "x86-64-avx512";
      # see src/evaluate.h for nnue names
      nnueBigFile = "nn-1111cefa1111.nnue";
      nnueSmallFile = "nn-37f18f62d772.nnue";
      nnueBig = prev.fetchurl {
        name = nnueBigFile;
        url = "https://tests.stockfishchess.org/api/nn/${nnueBigFile}";
        sha256 = "sha256-ERHO+hERa3cWG9SxTatMUPJuWSDHVvSGFZK+Pc1t4XQ=";
      };
      nnueSmall = prev.fetchurl {
        name = nnueSmallFile;
        url = "https://tests.stockfishchess.org/api/nn/${nnueSmallFile}";
        sha256 = "sha256-N/GPYtdy8xB+HWqso4mMEww8hvKrY+ZVX7vKIGNaiZ0=";
      };
    in prev.stockfish.overrideAttrs (previousAttrs: {
      version = "${version}-thib";
      src = prev.fetchFromGitHub {
        owner = "official-stockfish";
        repo = "Stockfish";
        rev = "sf_${version}";
        sha256 = "sha256-oXvLaC5TEUPlHjhm7tOxpNPY88QxYHFw+Cev3Q8NEeQ=";
      };
      postUnpack = ''
        sourceRoot+=/src
        cp "${nnueBig}" "$sourceRoot/${nnueBigFile}"
        cp "${nnueSmall}" "$sourceRoot/${nnueSmallFile}"
      '';
      makeFlags = [
        "PREFIX=$(out)"
        "ARCH=${arch}"
        "CXX=${prev.stdenv.cc.targetPrefix}c++"
      ];
      buildFlags = [ "build" ];
    });
  };
}
