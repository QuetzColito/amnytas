{
  description = "Quetz Nixos Configuration";

  # all the git repos needed
  inputs = {
    nixpkgs-other.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    ags.url = "github:Aylur/ags";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    putah.url = "github:QuetzColito/putah";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    hardware.url = "github:NixOS/nixos-hardware/master";

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      # url = "github:ezKEa/aagl-gtk-on-nix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf/v0.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "https://github.com/imputnet/helium-linux/releases/download/0.5.7.1/helium-0.5.7.1-x86_64.AppImage";
      flake = false;
    };

    poetrade = {
      url = "https://github.com/SnosMe/awakened-poe-trade/releases/download/v3.27.101/Awakened-PoE-Trade-3.27.101.AppImage";
      flake = false;
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = inputs.nixpkgs-other.legacyPackages.${system};
    theme = import ./theme.nix pkgs;
    inherit (pkgs) lib;
    hh = {
      mkList = i: is: builtins.concatStringsSep "\n${i}=" ([""] ++ is);
    };
    # builds the system flake output for every host
    mkSystemConfig = {
      host,
      user,
    }: {
      name = host;
      # System Config
      value = nixpkgs.lib.nixosSystem {
        # pass these in so we can access all the flake inputs in the config
        specialArgs = {inherit inputs self pkgs-unstable hh theme;};
        modules = [
          ./config
          ./hosts/${host}.nix
          ./hosts/hardware/${host}.nix
          {
            nixpkgs.hostPlatform = system;
            mainUser = user;
            hostName = host;
          }
        ];
      };
    };
  in {
    # apply the functions to the hostlist
    nixosConfigurations =
      (builtins.listToAttrs (map mkSystemConfig (import ./hosts)))
      // {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs self pkgs-unstable hh theme;};
          modules = [
            inputs.nixos-wsl.nixosModules.default
            ./hosts/wsl.nix
            {
              wsl.enable = true;
            }
          ];
        };
      };

    # This will make the package available as a flake output under 'packages'
    packages.x86_64-linux.nvf =
      (inputs.nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./nvf];
      })
      .neovim;

    # install script, does the following
    # - clone the repo into ~/amnytas
    # - ask for the 4 module options
    # - try to extract stateVersion from /etc/nixos/configuration.nix
    # - add a new host to hosts/default.nix
    # - regenerate the hardware-configuration and adds it under hardware/<host>.nix directory
    # - also create host-specific <host>.nix
    # - run nixos-rebuild switch
    # cancel it during the rebuild if you wanna change someting before the first build
    install =
      pkgs.writeShellScriptBin "install"
      ''
        cd ~
        # ${lib.getExe pkgs.git} clone https://github.com/QuetzColito/amnytas.git
        cd amnytas/hosts || (echo "couldnt find ~/amnytas/hosts, did the git clone fail?" & exit)

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

        read -p "Do you want to install grub? (y/n, default: no) (you may have to choose it in bios afterwards)
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

        echo "adding new host $user@$host to hostlist"
        hostlist="default.nix"

        sed -i '$ d' "$hostlist"
        echo "    { host = \"$host\"; user = \"$user\"; }" >> "$hostlist"
        echo "]" >> "$hostlist"

        nixos-generate-config --show-hardware-config > hardware/$host.nix

        echo "{...} : {
            isNvidia = $nvidia;
            wantGrub = $grub;
            firstInstall = true; # You can remove this after install
            system$stateVersion
        }" >> $host.nix

        ${lib.getExe pkgs.git} add .

        echo "running 'sudo nixos-rebuild switch --flake ~/amnytas#$host $installBootloader' to build system config"
        sudo nixos-rebuild switch --flake ~/amnytas#$host $installBootloader
      '';
  };
}
