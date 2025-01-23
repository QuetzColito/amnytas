{...}: {
  home = {
    stateVersion = "24.11";
    # set to the nixpkgs version of your system (look at /etc/nixos/configuration.nix if unsure)
  };

  # unless you know your monitor names, leave this empty for first install, and then adjust
  monitors = [
    # {
    #     # the output name (check hyprctl monitors)
    #     name = "HDMI-A-1";
    #
    #     # optional, if you dont want wallpapers per workspace
    #     # wallpaper = "~/amnytas/wallpaper/side.jpg";
    #
    #     # optional if you need it
    #     # rotation = "1";
    #
    #     # coordinates of the upper left corner of the monitor (in pixels)
    #     coords = "0x0";
    #
    #     # all workspaces that should spawn on this monitor
    #     workspaces = [ 1 2 3 4 5 6 7 8 9 ];
    #
    #     # optional, if you need a custom config (still set the other required values tho)
    #     config = ""
    # }
  ];
}
