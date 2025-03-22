{
  lib,
  config,
  ...
}: {
  imports = [
    ./binds.nix
    ./rules.nix
    ./programs.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hypridle.nix
    ./uwsm.nix
  ];

  # This option is used for hyprland monitor setup, hyprlock and hyprpaper
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
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;
      # Trails \o/
      # plugins = [pkgs.hyprlandPlugins.hyprtrails];
      settings = {
        exec-once =
          [
            "uwsm finalize"
            # fake login screen
            "hyprlock --immediate; killall -r fcitx5"
            # Widgets and Bar
            "ags run ~/amnytas/home/rice/ags/app.ts"
            # Wallpaperswitcher
            "hyprpaperswitch"
            # gotta find a way to do this properly, but for now this works
            "systemctl --user start nm-applet"
            # Keyboardlayout for proton (why you gotta be so difficult x.x)
            "setxkbmap -layout ${config.home.keyboard.layout} ${builtins.concatStringsSep " " (map (o: "-option '${o}'") config.home.keyboard.options)}"
          ]
          # Used to help with games, dunno if still needed
          ++ (map ({name, ...}: "xrandr --output " + name + " --primary") config.monitors);

        # Nix magic :D
        workspace = builtins.concatLists (
          map (
            {
              workspaces,
              name,
              ...
            }:
              map (ws: (builtins.toString ws) + ", monitor:" + name) workspaces
          )
          config.monitors
        );

        monitor =
          [
            # ",highrr,auto,1"
            "Unknown-1,disable"
          ]
          ++ map (
            {
              name,
              coords,
              rotation ? "",
              ...
            } @ monitor:
              monitor.config
              or (name
                + ",preferred,"
                + coords
                + ",1"
                + (
                  if rotation == ""
                  then ""
                  else ",transform," + rotation
                ))
          )
          config.monitors;

        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"

          "CLUTTER_BACKEND,wayland"
          # "SDL_VIDEODRIVER=wayland"
          "QT_QPA_PLATFORM,wayland;xcb"
          "GDK_BACKEND,wayland,x11,*"

          # Nvidia
          "LIBVA_DRIVER_NAME,nvidia"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "__GL_GSYNC_ALLOWED,0"
          "__GL_VRR_ALLOWED,0"
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
          "NIXOS_OZONE_WL,1"

          # needed to get the layout into gamescope
          ("XKB_DEFAULT_LAYOUT," + config.wayland.windowManager.hyprland.settings.input.kb_layout)
          ("XKB_DEFAULT_OPTIONS," + config.wayland.windowManager.hyprland.settings.input.kb_options)
        ];

        gestures = {
          workspace_swipe = true;
          workspace_swipe_invert = true;
        };

        xwayland = {
          force_zero_scaling = true;
        };

        input = {
          # keyboard layout (eu is us with extra combinations for ä,ï and stuff)
          kb_layout = config.home.keyboard.layout;
          # caps as escape best change of my life
          kb_options = builtins.concatStringsSep "," config.home.keyboard.options;
          follow_mouse = 1;
          accel_profile = "flat";
          sensitivity = 0.0;
          touchpad = {
            clickfinger_behavior = true;
            tap-to-click = true;
            scroll_factor = 0.5;
          };
        };

        # nvidia-specific
        cursor = {
          no_hardware_cursors = true;
        };

        general = {
          # gaps
          gaps_in = 0;
          gaps_out = 0;

          # border thiccness
          border_size = 2;

          # gradient border \o/
          "col.active_border" = lib.mkForce "rgb(${config.stylix.base16Scheme.base0C}) rgb(${config.stylix.base16Scheme.base0E}) 45deg";
        };

        plugin.hyprtrails.color = "rgba(${config.stylix.base16Scheme.base0E}88)";

        decoration = {
          # fancy corners
          rounding = 0;

          # blur
          blur = {
            enabled = true;
            size = 3;
            passes = 3;
            ignore_opacity = false;
            new_optimizations = 1;
            xray = true;
            contrast = 0.7;
            brightness = 0.8;
          };
        };

        misc = {
          # disable redundant renders
          disable_splash_rendering = true;
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
          font_family = "Inter";

          vfr = true;

          # window swallowing
          enable_swallow = true; # hide windows that spawn other windows
          swallow_regex = "^(foot)$";
          swallow_exception_regex = "^.*Yazi.*$";

          # dpms
          mouse_move_enables_dpms = true; # enable dpms on mouse/touchpad action
          key_press_enables_dpms = true; # enable dpms on keyboard action
          disable_autoreload = true; # autoreload is unnecessary on nixos, because the config is readonly anyway
        };

        # render.explicit_sync = 0;
        dwindle.preserve_split = true;

        animations = {
          enabled = true;
          first_launch_animation = true;

          bezier = [
            "smoothIn, 0.5, 0, 0.75, 0"
            "smoothOut, 0.25, 1, 0.5, 1"
            "linear, 0.0, 0.0, 1.0, 1.0"
          ];

          animation = [
            "windows, 1, 2, smoothIn, slide"

            # rotating border
            "border,1,10,default"
            "borderangle, 1, 100, linear, loop"

            "fade, 1, 10, smoothOut"
            "fadeDim, 1, 10, smoothOut"
            "workspaces,1,3,smoothOut,slidefadevert 50%"
          ];
        };
      };
    };
  };
}
