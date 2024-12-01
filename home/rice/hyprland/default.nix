{
  lib,
  pkgs,
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
          wallpaper = "~/amnytas/wallpaper/4.png";
          workspaces = [1 2 3 4 5 6 7 8 9];
        }
      ];
      type = lib.types.listOf lib.types.attrs;
    };
  };

  config = let
  in {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd = {
        # dunno why this is here but looks important
        variables = ["--all"];
        extraCommands = [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };
      # Trails \o/
      plugins = [pkgs.hyprlandPlugins.hyprtrails];
      settings = {
        exec-once =
          [
            # fake login screen
            "hyprlock --immediate"
            "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
            "systemctl --user import-environment PATH && systemctl --user restart xdg-desktop-portal.service"
            # "ags run ~/amnytas/home/rice/ags/app.ts"
            "hyprpaperswitch"
            # this used to help with games, dunno if still needed
          ]
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
              if monitor ? config
              then monitor.config
              else
                name
                + ",preferred,"
                + coords
                + ",1"
                + (
                  if rotation == ""
                  then ""
                  else ",transform," + rotation
                )
          )
          config.monitors;

        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "CLUTTER_BACKEND,wayland"
          # "SDL_VIDEODRIVER,wayland"
          "QT_QPA_PLATFORM,wayland;xcb"
          "GDK_BACKEND,wayland,x11,*"
          "XCURSOR_THEME,Bibata-Modern-Classic"
          "LIBVA_DRIVER_NAME,nvidia"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "__GL_GSYNC_ALLOWED,0"
          "__GL_VRR_ALLOWED,0"
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
          "NIXOS_OZONE_WL,1"
          # "AQ_NO_ATOMIC,1"
          "NVD_BACKEND,direct"
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
          kb_layout = "eu";
          # caps as escape best change of my life
          kb_options = "caps:escape,lv3:switch";
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
          gaps_in = 6;
          gaps_out = 11;

          # border thiccness
          border_size = 2;

          # active border color
          # gradient border \o/
          "col.active_border" = lib.mkForce "rgb(${config.stylix.base16Scheme.base0C}) rgb(${config.stylix.base16Scheme.base0E}) 45deg";
        };

        plugin.hyprtrails.color = "rgba(${config.stylix.base16Scheme.base0E}ff)";

        decoration = {
          # fancy corners
          rounding = 7;

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

          # shadow config
          # drop_shadow = "no";
          # shadow_range = 20;
          # shadow_render_power = 5;
          #"col.shadow" = "rgba(292c3cee)";
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

        animations = {
          enabled = true;
          first_launch_animation = true;

          bezier = [
            "smoothOut, 0.36, 0, 0.66, -0.56"
            "smoothIn, 0.25, 1, 0.5, 1"
            "overshot, 0.4,0.8,0.2,1.2"
            "linear, 0.0, 0.0, 1.0, 1.0"
          ];

          animation = [
            "windows, 1, 4, smoothIn, slide"
            # "windowsOut, 1, 3, smoothIn, slide"
            # rotating border
            "border,1,10,default"
            "borderangle, 1, 100, linear, loop"

            "fade, 1, 10, smoothIn"
            "fadeDim, 1, 10, smoothIn"
            "workspaces,1,4,smoothIn,slidefadevert 50%"
          ];
        };

        dwindle = {
          pseudotile = false;
          preserve_split = "yes";
          # no_gaps_when_only = false;
        };

        debug = {
          disable_logs = false;
        };
      };
    };
  };
}
