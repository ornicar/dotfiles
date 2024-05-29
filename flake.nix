{
  description = "Thibs's nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
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
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-master,
    nixos-hardware,
    home-manager,
    ...
  } @ inputs: 
  let
    inherit (self) outputs;
    inherit (nixpkgs.lib) nixosSystem;
    specialArgs = { inherit inputs outputs nixpkgs-master; };
  in {
    nixosConfigurations = {
      fw = nixosSystem {
        specialArgs = specialArgs;
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.users.thib = import ./home/fw.nix;
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
            home-manager.users.thib = import ./home/crom.nix;
            home-manager.extraSpecialArgs = specialArgs;
          }
          ./system/crom
        ];
      };
    };
  };
}
