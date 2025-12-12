{
  theme,
  config,
  hh,
  ...
}: {
  files = {
    ".config/hypr/generated.conf".text =
      ''
        general {
          col.active_border = rgb(${theme.base0C}) rgb(${theme.base0E}) 45deg
          col.inactive_border = rgb(${theme.base02})
        }
        input {
          kb_layout = ${config.services.xserver.xkb.layout}
          kb_variant = ${config.services.xserver.xkb.variant}
          kb_model =
          kb_options = ${config.services.xserver.xkb.options}
          kb_rules =
        }
        cursor {
          no_hardware_cursors = ${
          if config.isNvidia
          then "1"
          else "2"
        }
        }
        misc {
          font_family = "${theme.sansSerif.name}"
        }
      ''
      + hh.mkList "workspace" ([
          "name:pseudofullscreen, gapsin:0, gapsout:0, rounding:false, bordersize:0"
        ]
        ++ (builtins.concatLists (
          map (
            {
              workspaces,
              name,
              ...
            }:
              map (ws: "${builtins.toString ws}, monitor:${name}") workspaces
          )
          config.monitors
        )))
      + ''

        env = XDG_CURRENT_DESKTOP,Hyprland
        env = XDG_SESSION_TYPE,wayland
        env = XDG_SESSION_DESKTOP,Hyprland
        env = CLUTTER_BACKEND,wayland
        # env = SDL_VIDEODRIVER,wayland
        env = GDK_BACKEND,wayland,x11,*
        env = QT_QPA_PLATFORM,wayland;xcb
        env = QT_QPA_PLATFORMTHEME,qt6ct
        env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
        env = XCURSOR_THEME,${theme.cursor.name}
        env = XCURSOR_SIZE,${theme.cursor.size}
        env = GTK_THEME,${theme.gtk.name}
        env = XKB_DEFAULT_LAYOUT,${config.services.xserver.xkb.layout}
        env = XKB_DEFAULT_VARIANT,${config.services.xserver.xkb.variant}
        env = XKB_DEFAULT_OPTIONS,${config.services.xserver.xkb.options}
      ''
      + (
        if config.isNvidia
        then ''
          "LIBVA_DRIVER_NAME=nvidia"
          "GBM_BACKEND=nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME=nvidia"
          "__GL_GSYNC_ALLOWED=0"
          "__GL_VRR_ALLOWED=0"
          "ELECTRON_OZONE_PLATFORM_HINT=auto"
          "NIXOS_OZONE_WL=1"
        ''
        else ''''
      );

    ".config/hypr/monitors.conf".text =
      hh.mkList "monitor"
      ([
          ",highrr,auto,1"
          "Unknown-1,disable"
        ]
        ++ (map (
            {
              name,
              coords,
              rotation ? "",
              ...
            } @ monitor:
              monitor.config
            or ("${name},preferred,${coords},1"
                + (
                  if rotation == ""
                  then ""
                  else ",transform," + rotation
                ))
          )
          config.monitors));
  };
}
