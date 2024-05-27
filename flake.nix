{
  description = "Thibs's nix config";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = {
    self,
    nixpkgs-unstable,
    nixpkgs-master,
    nixos-hardware,
    home-manager,
    ...
  } @ inputs: 
  let
    inherit (self) outputs;
    specialArgs = {inherit inputs outputs nixpkgs-master;};
  in {
    nixosConfigurations = {
      fw = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = specialArgs;
        modules = [
          inputs.nixos-hardware.nixosModules.framework-16-7040-amd
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.thib = import ./home/fw.nix;
            home-manager.extraSpecialArgs = specialArgs;
          }
          inputs.stylix.nixosModules.stylix
          ./system/fw
        ];
      };
    };
  };
}
