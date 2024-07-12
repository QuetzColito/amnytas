{
    lib,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./programs/programs.nix
    ./dev/dev.nix
    ./rice/rice.nix
    ../stylix.nix
  ];
  home.shellAliases = {
    hs = "home-manager switch --flake ~/nixos";
    hn = "home-manager news --flake ~/nixos";
    ns = "sudo nixos-rebuild switch --flake ~/nixos";
  };

  services = {
    arrpc.enable = true;
    wlsunset = {
      # TODO: fix opaque red screen issue
      enable = false;
      latitude = "51.0";
      longitude = "11.0";
      temperature = {
        day = 6200;
        night = 3750;
      };
      systemdTarget = "hyprland-session.target";
    };
  };
  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
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
    #  name = "Tokyonight-Dark-B";
    #  package = pkgs.tokyonight-gtk-theme;
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

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      ipc = "off";
    };
  };
}
