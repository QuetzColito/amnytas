{
    description = "Quetz Nixos Configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
        nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
        zen-browser.url = "github:MarceColl/zen-browser-flake";
        ags.url = "github:Aylur/ags";
        nixos-cosmic = {
            url = "github:lilyinstarlight/nixos-cosmic";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        stylix.url = "github:danth/stylix";

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

    outputs = { self, nixos-cosmic, nixpkgs, aagl, nixos-wsl, nixpkgs-stable, home-manager, ... }@inputs:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        home-modules = [
            inputs.stylix.homeManagerModules.stylix
            inputs.nixvim.homeManagerModules.nixvim
            {
                home.packages = [
                        inputs.zen-browser.packages."${system}".specific
                    ];
                home.sessionVariables.BROWSER = "zen";
            }
        ];
        system-modules = [
            inputs.stylix.nixosModules.stylix
            nixos-cosmic.nixosModules.default
            {
                nix.settings = {
                    substituters = [ "https://cosmic.cachix.org/" ];
                    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                };
            }
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
            extraSpecialArgs = { inherit inputs; };
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
            extraSpecialArgs = { inherit inputs; };
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
            extraSpecialArgs = { inherit inputs; };
            modules = [
                ./home/melon.nix
            ] ++ home-modules;
        };

        # WSL
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                nixos-wsl.nixosModules.default
                inputs.stylix.nixosModules.stylix
                ./system/nixos/configuration.nix
            ];
        };
        homeConfigurations."nixos" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
                ./home/nixos.nix
                inputs.stylix.homeManagerModules.stylix
                inputs.nixvim.homeManagerModules.nixvim
            ];
        };
    };
}
