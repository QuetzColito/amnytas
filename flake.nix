{
  description = "Quetz Nixos Configuration";

  # all the git repos needed
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    ags.url = "github:Aylur/ags";
    stylix.url = "github:danth/stylix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty.url = "github:ghostty-org/ghostty";

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

    ytm-src = {
      url = "https://github.com/th-ch/youtube-music/releases/download/v3.7.1/YouTube-Music-3.7.1.AppImage";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-stable = nixpkgs-stable.legacyPackages.${system};
    lib = nixpkgs.lib;

    # builds the system flake output for every host
    mkSystemConfig = {
      host,
      user,
    }: {
      name = host;
      # System Config
      value = nixpkgs.lib.nixosSystem {
        # not sure if i need this, but doesnt hurt i guess
        inherit system;
        # pass these in so we can access all the flake inputs in the config
        specialArgs = {inherit inputs pkgs-stable system;};
        modules =
          [
            ./hosts/${host}
          ]
          ++ (
            # wsl uses a more basic config, since it is only tty
            if host == "wsl"
            then [
              {
                mainUser = "nixos";
                hostName = "nixos";
              }
            ]
            else [
              {
                mainUser = user;
                hostName = host;
              }
              ./hosts/${host}/hardware-configuration.nix
              ./system
            ]
          );
      };
    };
    mkHomeConfig = {
      host,
      user,
    }: {
      name = user;
      # Home Config
      value = home-manager.lib.homeManagerConfiguration {
        # not sure if i need this, but doesnt hurt i guess
        inherit pkgs;
        # pass these in so we can access all the flake inputs in the config
        extraSpecialArgs = {inherit inputs pkgs-stable system;};
        modules =
          [
            ./hosts/${host}/${user}.nix
            {
              home.username = user;
              hostName = host;
            }
            # wsl uses a more basic config, since it is only tty
          ]
          ++ (
            if host == "wsl"
            then []
            else [
              ./home
            ]
          );
      };
    };
  in {
    # apply the functions to the hostlist
    nixosConfigurations = builtins.listToAttrs (map mkSystemConfig (import ./hostlist.nix));
    homeConfigurations = builtins.listToAttrs (map mkHomeConfig (import ./hostlist.nix
      ++ [
        {
          host = "mabon";
          user = "arthezia-mobile";
        }
      ]));

    # install script, does the following
    # - clone the repo into ~/amnytas
    # - ask for the 4 module options
    # - try to extract stateVersion from /etc/nixos/configuration.nix
    # - add a new host to hostlist.nix
    # - regenerate the hardware-configuration and adds it to the new host directory
    # - also create host-specific home.nix for home-manger and default.nix for nixos
    # - run nixos-rebuild switch
    # - run home-manger switch
    # cancel it during the rebuild if you wanna change someting before the first build
    install =
      pkgs.writeShellScriptBin "install"
      ''
        cd ~
        ${lib.getExe pkgs.git} clone https://github.com/QuetzColito/amnytas.git
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

        ${lib.getExe pkgs.git} add .

        echo "running nixos-rebuild switch --flake ~/amnytas#$host $installBootloader to build system config"
        nixos-rebuild switch --flake ~/amnytas#$host $installBootloader

        echo "running home-manger switch --flake ~/amnytas#$user to generate user config"
        home-manger switch --flake ~/amnytas#$user
      '';
  };
}
