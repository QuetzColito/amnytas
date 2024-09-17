{
  pkgs,
  ...
}: {
    nixpkgs.config.allowUnfree = true;
    programs.home-manager.enable = true;

    imports = [
        ./programs
        ./rice
        ./terminal
        ../stylix.nix
    ];

    home.shellAliases = {
        hs = "home-manager switch --flake ~/nixos";
        hn = "home-manager news --flake ~/nixos";
        ns = "sudo nixos-rebuild switch --flake ~/nixos";
    };

    services = {
        arrpc.enable = true;
        hyprpaper = {
            enable = true;
            settings = {
                splash = false;
                ipc = "off";
            };
        };
    };

    systemd.user.targets.tray = {
        Unit = {
            Description = "Home Manager System Tray";
            Requires = ["graphical-session-pre.target"];
        };
    };

    gtk = {
        enable = true;
        gtk3.extraConfig.gtk-decoration-layout = "menu:";
        # theme = lib.mkForce {
        #     name = "Tokyonight-Dark-B";
        #     package = pkgs.tokyonight-gtk-theme;
        # };
        iconTheme = {
            name = "Tokyonight-Dark";
            package = pkgs.tokyonight-gtk-theme;
        };
        cursorTheme = {
            name = "Bibata-Modern-Classic";
            package = pkgs.bibata-cursors;
        };
    };
}
