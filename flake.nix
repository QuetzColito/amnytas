{
  description = "Quetz Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    stylix.url = "github:danth/stylix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

      # PEITHA
    nixosConfigurations.peitha = nixpkgs.lib.nixosSystem {
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs system;
      };
      modules = [
        ./system/peitha/configuration.nix
        inputs.stylix.nixosModules.stylix
      ];
    };
    homeConfigurations."quetz" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ 
        ./home/peitha.nix 
        inputs.stylix.homeManagerModules.stylix
      ];
    };

      # MABON
    nixosConfigurations.mabon = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./system/mabon/configuration.nix
      ];
    };
    homeConfigurations."arthezia" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home/mabon.nix ];
    };

      # ZOJJA
    nixosConfigurations.zojja = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./system/zojja/configuration.nix
      ];
    };
    homeConfigurations."melon" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home/melon.nix ];
    };
  };
}
