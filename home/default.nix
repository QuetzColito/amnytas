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
      # very handy for editing the config
      shellAliases = {
        e = "hyprctl dispatch exec --";
        hs = "home-manager switch --flake ~/amnytas";
        hn = "home-manager news --flake ~/amnytas";
        ns = "sudo nixos-rebuild switch --flake ~/amnytas";
        nu = "nix flake update --commit-lockfile";
      };
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
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
      };
    };
  };
}
