{
  description = "Thib's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
    # hyprfocus.url = "github:ornicar/hyprfocus";

    # locked commit to avoid recompiling every day 🤷‍♂️
    ashell.url = "github:MalpenZibo/ashell/845ca24797d5acc313ec38aafe4ec2efb2c67458";

    bbpPairings.url = "github:ornicar/bbpPairings/2b01f2c1e2b839d2";
    picfit.url = "github:ornicar/picfit/e64ee4fb03f65742ed2ff";

    # lan-mouse.url = "github:feschber/lan-mouse";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs.lib) nixosSystem;
      specialArgs = { inherit inputs outputs; };
    in
    {
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
