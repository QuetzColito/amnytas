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
        lib = nixpkgs.lib;
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
        nixosConfigurations = builtins.listToAttrs (map mkSystemConfig (import ./hostlist.nix));
        homeConfigurations = builtins.listToAttrs (map mkHomeConfig (import ./hostlist.nix));

        install = pkgs.writeShellScriptBin "install"
        ''
            cd ~
            ${lib.meta.getExe pkgs.git} clone https://github.com/QuetzColito/amnytas.git
            cd amnytas || (echo "couldnt find ~/amnytas, did the git clone fail?" & exit)

            read -p "What hostName should the system use?
            " host
            if [[ -z "$host" ]]; then
                echo "host cant be empty, aborting"; exit
            fi

            read -p "What is the name of your main user? (dont fuck this up)
            " user || exit
            if [[ -z "$user" ]]; then
                echo "user cant be empty, aborting"; exit
            fi

            read -p "Do you have an Nvidia Card (y/n, default: no)
            " nvidia
            if [[ "$nvidia" =~ ^[Yy]$ ]]; then
                nvidia=true
            else
                nvidia=false
            fi

            read -p "Do you want to install grub? (y/n, default: no) (you will have to enable it in bios)
            " grub
            if [[ "$grub" =~ ^[Yy]$ ]]; then
                grub=true
                installBootloader="--install-bootloader"
            else
                grub=false
                installBootloader=""
            fi

            stateVersion=$(cat /etc/nixos/configuration.nix | grep system.stateVersion | sed -r 's/^.*system//')
            if [[ -z "$stateVersion" ]]; then
                echo "couldnt determine stateVersion, defaulting to 24.05"
                stateVersion='.stateVersion = "24.05";'
            fi

            echo "adding new host to hostlist"
            hostlist="hostlist.nix"

            sed -i '$ d' "$hostlist"
            echo "    { host = \"$host\"; user = \"$user\"; }" >> "$hostlist"
            echo "]" >> "$hostlist"

            echo "creating new host directory"
            mkdir hosts/$host || (echo "hosts/$host already exists, aborting" & exit)
            cd hosts/$host

            nixos-generate-config --show-hardware-config > hardware-configuration.nix

            echo "{...} : {
                isNvidia = $nvidia;
                wantGrub = $grub;
                system$stateVersion
            }" >> default.nix

            echo "{...} : {
                home$stateVersion
            }" >> home.nix

            ${lib.meta.getExe pkgs.git} add .

            echo "running nixos-rebuild switch --flake ~/amnytas#$host $installBootloader to build system config"
            nixos-rebuild switch --flake ~/amnytas#$host $installBootloader

            echo "running home-manger switch --flake ~/amnytas#$user to generate user config"
            home-manger switch --flake ~/amnytas#$user
        '';

    };
}
