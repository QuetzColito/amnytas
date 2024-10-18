{
    description = "Quetz Nixos Configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
        zen-browser.url = "github:MarceColl/zen-browser-flake";
        ags.url = "github:Aylur/ags";
        stylix.url = "github:danth/stylix";

        nixos-cosmic = {
            url = "github:lilyinstarlight/nixos-cosmic";
            inputs.nixpkgs.follows = "nixpkgs";
        };

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
        hosts = [
            { host = "peitha"; user = "quetz"; }
            { host = "mabon"; user = "arthezia"; }
            { host = "zojja"; user = "melon"; }
            { host = "wsl"; user = "nixos"; }
        ];
        mkSystemConfig = {host, user }: {
            name = host;
            # System Config
            value = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs system; };
                modules = [
                    ./hosts/${host}
                ] ++ (if host == "wsl" then [ {mainUser = "nixos"; hostName = "nixos"; } ] else [
                    { mainUser = user; hostName = host; }
                    ./hosts/${host}/hardware-configuration.nix
                    ./system
                ]);
            };
        };
        mkHomeConfig = {host, user}: {
            name = user;
            # Home Config
            value = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = { inherit inputs system; };
                modules = [
                    ./hosts/${host}/home.nix
                    { home.username = user;}
                ] ++ (if host == "wsl" then [] else [
                    ./home
                ]);
            };
        };
    in {
        nixosConfigurations = builtins.listToAttrs (map mkSystemConfig hosts);
        homeConfigurations = builtins.listToAttrs (map mkHomeConfig hosts);
    };
}
