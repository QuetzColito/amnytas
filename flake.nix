{
  description = "Quetz Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations.peitha = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./system/peitha/configuration.nix
      ];
    };
    homeConfigurations."quetz" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home/peitha.nix ];
    };

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
  };
}
