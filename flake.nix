{
  description = "Thibs's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-mongodb-pin.url =
      "github:NixOS/nixpkgs/e913ae340076bbb73d9f4d3d065c2bca7caafb16";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

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

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs.lib) nixosSystem;
      specialArgs = { inherit inputs outputs; };
      overlays = import ./system/overlays.nix inputs;
    in {
      nixosConfigurations = {
        fw = nixosSystem {
          specialArgs = specialArgs;
          modules = [
            overlays
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
            overlays
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
