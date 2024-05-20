{
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
    #theme = {
    #  name = "Tokyonight-Dark-BL";
    #  package = pkgs.tokyo-night-gtk;
    #};
    iconTheme = {
      name = "Tokyonight-Dark";
     package = pkgs.tokyo-night-gtk;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };
}
