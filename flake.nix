{
  description = "Thib's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    nixpkgs-mongodb-pin.url =
      "github:NixOS/nixpkgs/fd4f8ce9fc5a4a1140b6648d576c42ce41caf8fe";

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

    bbpPairings.url = "github:ornicar/bbpPairings";

    # lan-mouse.url = "github:feschber/lan-mouse";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs.lib) nixosSystem;
      specialArgs = { inherit inputs outputs; };
    in {
      overlays = import ./nix/overlays { inherit inputs; };
      nixosConfigurations = {
        fw = nixosSystem {
          specialArgs = specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.users.thib = import ./nix/home/fw;
              home-manager.extraSpecialArgs = specialArgs;
            }
            ./nix/system/fw
          ];
        };
        crom = nixosSystem {
          specialArgs = specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.users.thib = import ./nix/home/crom;
              home-manager.extraSpecialArgs = specialArgs;
            }
            ./nix/system/crom
          ];
        };
      };
    };
}
