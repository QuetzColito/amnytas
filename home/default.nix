{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    ./programs
    ./rice
    ./terminal
    ../stylix.nix
    inputs.stylix.homeManagerModules.stylix
  ];

  options = {
    hostName = lib.mkOption {
      default = "nixos";
      type = lib.types.str;
    };
  };

  config = {
    nixpkgs.config.allowUnfree = true;
    programs.home-manager.enable = true;

    home = {
      homeDirectory = "/home/${config.home.username}";
      shellAliases = {
        e = "hyprctl dispatch exec --";
        lz = "lazygit";
        hs = "home-manager switch --flake ~/amnytas";
        hn = "home-manager news --flake ~/amnytas";
        ns = "sudo nixos-rebuild switch --flake ~/amnytas";
        nu = "nix flake update --commit-lock-file";
      };
    };

    home.keyboard = {
      layout = "eu";
      options = [
        "caps:escape"
        "lv3:switch"
      ];
    };

    # Discord Web Rich Presence (for vesktop)
    services.arrpc.enable = true;

    gtk = {
      enable = true;
      gtk3.extraConfig.gtk-decoration-layout = "menu:";
      # couldnt get the Tokyonight icon theme to work, and i dont see them often anyways
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      cursorTheme = {
        name = "Miku-Cursor";
        # package = pkgs.bibata-cursors;
      };
    };
  };
}
