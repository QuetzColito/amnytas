{config, ...}: {
  # this is from the wiki
  xdg.configFile = {
    "uwsm/env-hyprland".text = builtins.concatStringsSep "\nexport " [
      ""
      # AQ_NO_MODIFIERS=1
    ];
    "hypr/xdph.conf".text = ''
      screencopy {
        allow_token_by_default = true
      }
    '';
    "uwsm/env".text = builtins.concatStringsSep "\nexport " [
      ""
      "CLUTTER_BACKEND=wayland"
      # "SDL_VIDEODRIVER=wayland"
      "QT_QPA_PLATFORM=wayland;xcb"
      "GDK_BACKEND=wayland,x11,*"

      # Nvidia
      "LIBVA_DRIVER_NAME=nvidia"
      "GBM_BACKEND=nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME=nvidia"
      "__GL_GSYNC_ALLOWED=0"
      "__GL_VRR_ALLOWED=0"
      "ELECTRON_OZONE_PLATFORM_HINT=auto"
      "NIXOS_OZONE_WL=1"

      # Keyboard for games/gamescope
      ("XKB_DEFAULT_LAYOUT=" + config.wayland.windowManager.hyprland.settings.input.kb_layout)
      ("XKB_DEFAULT_OPTIONS=" + config.wayland.windowManager.hyprland.settings.input.kb_options)
    ];
  };
}
