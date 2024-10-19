{
  pkgs,
  inputs,
  config,
  ...
}: {
    nixpkgs.config.allowUnfree = true;
    programs.home-manager.enable = true;

    imports = [
        ./programs
        ./rice
        ./terminal
        ../stylix.nix inputs.stylix.homeManagerModules.stylix
    ];

    home = {
        homeDirectory = "/home/${config.home.username}";
        shellAliases = {
            hs = "home-manager switch --flake ~/amnytas";
            hn = "home-manager news --flake ~/amnytas";
            ns = "sudo nixos-rebuild switch --flake ~/amnytas";
        };
    };

    services.arrpc.enable = true;

    gtk = {
        enable = true;
        gtk3.extraConfig.gtk-decoration-layout = "menu:";
        iconTheme = {
            name = "Tokyonight-Dark";
            package = pkgs.elementary-xfce-icon-theme;
        };
        cursorTheme = {
            name = "Bibata-Modern-Classic";
            package = pkgs.bibata-cursors;
        };
    };
}
