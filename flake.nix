{
  description = "Quetz Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    stylix.url = "github:danth/stylix";
    xremap-flake.url = "github:xremap/nix-flake";

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, aagl, nixpkgs-stable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      home-modules = [
        inputs.stylix.homeManagerModules.stylix
        inputs.nixvim.homeManagerModules.nixvim
      ];
      system-modules = [
        inputs.stylix.nixosModules.stylix
        inputs.xremap-flake.nixosModules.default
         {
          imports = [ aagl.nixosModules.default ];
          nix.settings = aagl.nixConfig; # Set up Cachix
          programs.honkers-railway-launcher.enable = true;
        }
      ];
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
      ] ++ system-modules;
    };
    homeConfigurations."quetz" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ 
        ./home/peitha.nix 
      ] ++ home-modules;
    };

      # MABON
    nixosConfigurations.mabon = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./system/mabon/configuration.nix
      ] ++ system-modules;
    };
    homeConfigurations."arthezia" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ 
        ./home/mabon.nix
      ] ++ home-modules;
    };

      # ZOJJA
    nixosConfigurations.zojja = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./system/zojja/configuration.nix
      ] ++ system-modules;
    };
    homeConfigurations."melon" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ 
        ./home/melon.nix 
      ] ++ home-modules;
    };
  };
}
