{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./machines/arthezia/configuration.nix
        # inputs.home-manager.nixosModules.default
      ];
    };
    nixosConfigurations.genshin = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./machines/artheziaconfiguration-genshin.nix
        # inputs.home-manager.nixosModules.default
      ];
    };
  };
}
