{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hyprutils
    ./rules.nix
    ./binds.nix
    ./conf.nix
    ./monitors.nix
    ./autostart.nix
  ];

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
  options = {
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

  config = {
    environment.systemPackages = with pkgs; [
      libnotify
    ];

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    services.getty.autologinUser = config.mainUser;

    environment.loginShellInit = ''
      if uwsm check may-start; then
          exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
}
