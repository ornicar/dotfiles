{
  description = "Thibs's NixOS config";

  inputs = {
    nixpkgs.url = # revert to (2024-06-18)
      "github:NixOS/nixpkgs/c00d587b1a1afbf200b1d8f0b0e4ba9deb1c7f0e";

    nixpkgs-mongodb.url =
      "github:NixOS/nixpkgs/e913ae340076bbb73d9f4d3d065c2bca7caafb16";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    lan-mouse.url = "github:feschber/lan-mouse";
  };

  outputs = { self, nixpkgs, nixpkgs-mongodb, nixos-hardware, home-manager, ...
    }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs.lib) nixosSystem;
      specialArgs = {
        inherit inputs outputs;
        pkgs-mongodb = import nixpkgs-mongodb {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
    in {
      nixosConfigurations = {
        fw = nixosSystem {
          specialArgs = specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.users.thib = import ./home/fw;
              home-manager.extraSpecialArgs = specialArgs;
            }
            ./system/fw
          ];
        };
        crom = nixosSystem {
          specialArgs = specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.users.thib = import ./home/crom;
              home-manager.extraSpecialArgs = specialArgs;
            }
            ./system/crom
          ];
        };
      };
    };
}
