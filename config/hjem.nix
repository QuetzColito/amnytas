{
  inputs,
  config,
  lib,
  ...
}: {
  options = {
    # shorthand for config files
    files = lib.mkOption {
      default = {};
      type = lib.types.attrs;
    };

    # shorthand for packages
    packages = lib.mkOption {
      default = [];
      type = lib.types.listOf lib.types.package;
    };

    # This option is used for hyprland monitor setup, hyprlock, hyprpaper and hyprpaperswitch
    # wants the following attributes
    # Required:
    #   - name, the name of the output, like DP-2 or HDMI-A-1
    #   - coords, where the upper left corner of the monitor should be
    #   - workspaces, which workspaces should be on that monitor
    # Optional:
    #   - rotation, if for example you have a vertical monitor,
    #               which hyprpaper will then assume (no matter which rotation)
    #   - wallpaper, if you dont want workspaces-specific wallpapers (why tho? :o)
    #   - config, if you need a custom configstring for hyprland (still set the required attributes tho)
    # Declared here so ./rice does not have to be imported
    monitors = lib.mkOption {
      default = [
        {
          name = "";
          coords = "0x0";
          wallpaper = "~/amnytas/wallpaper/7.png";
          workspaces = [1 2 3 4 5 6 7 8 9];
        }
      ];
      type = lib.types.listOf lib.types.attrs;
    };
  };

  imports = [
    inputs.hjem.nixosModules.default
  ];

  config = {
    hjem.clobberByDefault = true;
    hjem.users.${config.mainUser} = {
      enable = true;
      user = config.mainUser;
      directory = "/home/${config.mainUser}";
      inherit (config) files;
    };

    users.users.${config.mainUser} = {inherit (config) packages;};
  };
}
