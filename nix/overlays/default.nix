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
      version = "candidate_1.0rc2";
      src = prev.fetchFromGitHub {
        owner = "CalcProgrammer1";
        repo = "OpenRGB";
        rev = "a589a0f0b863450aa8cfac9d46f8eac808eab374";
        hash = "sha256-qp2bsQw9sfv6o+qYTe9VerX98GkxRSTaHsAgMvjfZSg=";
      };
      patches = [ ];

      postPatch = ''
        patchShebangs scripts/build-udev-rules.sh
        substituteInPlace scripts/build-udev-rules.sh \
          --replace /bin/chmod "${prev.coreutils}/bin/chmod"
        substituteInPlace scripts/build-udev-rules.sh \
          --replace /usr/bin/env "${prev.coreutils}/bin/env"
      '';
    });

    easyeffects = (import inputs.nixpkgs-stable {
      system = final.system;
      config.allowunfree = true;
    }).easyeffects;

    # esbuild = prev.esbuild.overrideAttrs (previousAttrs: rec {
    #   version = "0.25.9";
    #   src = prev.fetchFromGitHub {
    #     owner = "evanw";
    #     repo = "esbuild";
    #     rev = "v${version}";
    #     hash = "sha256-eaYDUKtTEisSNyb5KN+32JX1yY/UJ4/UDQwzToEMAkw=";
    #   };
    # });

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
