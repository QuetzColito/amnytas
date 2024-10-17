{
    description = "Quetz Nixos Configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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

    outputs = { nixpkgs, home-manager, ... }@inputs:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        mkSystemConfig = name: {
            inherit name;
            # System Config
            value = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs system; };
                modules = [
                    ./system/${name}
                ] ++ (if name == "wsl" then [] else [ ./system/general ./system/${name}/hardware-configuration.nix ]) ;
            };
        };
        mkHomeConfig = name: {
            inherit name;
            # Home Config
            value = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = { inherit inputs system; };
                modules = [
                    ./home/${name}.nix
                ] ++ (if name == "wsl" then [] else [ ./home/home.nix ]) ;
            };
        };
    in {
        nixosConfigurations = builtins.listToAttrs (map mkSystemConfig [ "peitha" "mabon" "zojja" "wsl" "visitor" ]);

        homeConfigurations = builtins.listToAttrs (map mkHomeConfig [ "quetz" "arthezia" "melon" "wsl" "visitor" ]);
    };
}
