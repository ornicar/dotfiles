{ ... }: {

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
  };
}
