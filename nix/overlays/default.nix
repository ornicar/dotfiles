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

    # Get latest bloop
    # bloop = (import inputs.nixpkgs-master {
    #   system = final.system;
    #   config.allowunfree = true;
    # }).bloop;

    # stable gimp
    gimp = (import inputs.nixpkgs-stable {
      system = final.system;
      config.allowunfree = true;
    }).gimp;

    # stable neovim
    # neovim = (import inputs.nixpkgs-stable {
    #   system = final.system;
    #   config.allowunfree = true;
    # }).neovim;

    openrgb = prev.openrgb.overrideAttrs (previousAttrs: {
      version = "candidate_1.0rc1.thib";
      src = prev.fetchFromGitHub {
        owner = "ornicar";
        repo = "OpenRGB";
        rev = "148e0b945a3dd4a4e36b264e2fc2bdf5b0d4979e";
        hash = "sha256-qp2bsQw9sfv6o+qYTe9VerX98GkxRSTaHsAgMvjfZSg=";
      };

      postPatch = ''
        patchShebangs scripts/build-udev-rules.sh
        substituteInPlace scripts/build-udev-rules.sh \
          --replace /bin/chmod "${prev.coreutils}/bin/chmod"
        substituteInPlace scripts/build-udev-rules.sh \
          --replace /usr/bin/env "${prev.coreutils}/bin/env"
      '';
    });

    stockfish = let
      version = "17.1";
      arch = "x86-64-avx512";
      # see src/evaluate.h for nnue names
      nnueBigFile = "nn-1c0000000000.nnue";
      nnueSmallFile = "nn-37f18f62d772.nnue";
      nnueBig = prev.fetchurl {
        name = nnueBigFile;
        url = "https://tests.stockfishchess.org/api/nn/${nnueBigFile}";
        sha256 = "sha256-HAAAAAAApn1imZnZMtDDc/dFDOQ80S0FYoaPTq+a4q0=";
      };
      nnueSmall = prev.fetchurl {
        name = nnueSmallFile;
        url = "https://tests.stockfishchess.org/api/nn/${nnueSmallFile}";
        sha256 = "sha256-N/GPYtdy8xB+HWqso4mMEww8hvKrY+ZVX7vKIGNaiZ0=";
      };
    in prev.stockfish.overrideAttrs (previousAttrs: {
      version = "${version}";
      src = prev.fetchFromGitHub {
        owner = "official-stockfish";
        repo = "Stockfish";
        rev = "sf_${version}";
        sha256 = "sha256-c8o1d7/yPnF3Eo7M/MSzYuYQr2qt2tIwyu7WfuKMAzg=";
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
