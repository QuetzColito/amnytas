{
  config,
  theme,
  lib,
  ...
}: {
  files = {
    ".config/hypr/hyprland.conf".text = ''
      source = ~/.config/hypr/rules.conf
      source = ~/.config/hypr/binds.conf
      source = ~/.config/hypr/autostart.conf
      source = ~/.config/hypr/monitors.conf

      general {
          gaps_in = 0
          gaps_out = 0

          border_size = 2

          col.active_border = rgb(${theme.base0C}) rgb(${theme.base0E}) 45deg
          col.inactive_border = rgb(${theme.base02})

          allow_tearing = false
      }

      decoration {
          rounding = 7
          blur {
              enabled = true
              size = 3
              passes = 1
              vibrancy = 0.1696
          }
      }

      animations {
          enabled = yes, please :)

          bezier=smoothIn, 0.5, 0, 0.75, 0
          bezier=smoothOut, 0.25, 1, 0.5, 1
          bezier=linear, 0.0, 0.0, 1.0, 1.0

          animation=windows, 1, 2, smoothOut, popin
          animation=windowsMove, 1, 2, smoothIn
          # rotating border
          animation=border,1,10,default
          animation=borderangle, 1, 100, linear, loop
          animation=fade, 1, 10, smoothOut
          animation=fadeDim, 1, 10, smoothOut
          animation=workspaces,1,3,smoothOut,slidefadevert 50%
      }
      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle {
          preserve_split = true # You probably want this
      }

      input {
          kb_layout = ${config.services.xserver.xkb.layout}
          kb_variant = ${config.services.xserver.xkb.variant}
          kb_model =
          kb_options = ${config.services.xserver.xkb.options}
          kb_rules =

          follow_mouse = 1
          accel_profile = flat

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

          touchpad {
              natural_scroll = false
          }
      }

      misc {
        font_family = "${theme.sansSerif.name}"
        disable_splash_rendering = true
        disable_hyprland_logo = true
        mouse_move_enables_dpms = true # enable dpms on mouse/touchpad action
        key_press_enables_dpms = true # enable dpms on keyboard action
      }

      cursor {
        no_hardware_cursors = ${
        if config.isNvidia
        then "1"
        else "2"
      }
      }

      device {
        name = elan050a:01-04f3:3158-touchpad
        sensitivity = +1.0
      }

      gestures {
          workspace_swipe = true
          workspace_swipe_invert = true
      }
    '';

    ".config/uwsm/env".text = builtins.concatStringsSep "\nexport " ([
        ""
        "CLUTTER_BACKEND=wayland"
        # "SDL_VIDEODRIVER=wayland"
        "QT_QPA_PLATFORM=wayland;xcb"
        "QT_QPA_PLATFORMTHEME=qt6ct"
        "GDK_BACKEND=wayland,x11,*"
        "XCURSOR_THEME=${theme.cursor.name}"
        "XCURSOR_SIZE=${theme.cursor.size}"
        "GTK_THEME=${theme.gtk.name}"
      ]
      ++ (
        if config.isNvidia
        then [
          "LIBVA_DRIVER_NAME=nvidia"
          "GBM_BACKEND=nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME=nvidia"
          "__GL_GSYNC_ALLOWED=0"
          "__GL_VRR_ALLOWED=0"
          "ELECTRON_OZONE_PLATFORM_HINT=auto"
          "NIXOS_OZONE_WL=1"
        ]
        else []
      ));
  };
}
