{
  description = "Thibs's NixOs config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
