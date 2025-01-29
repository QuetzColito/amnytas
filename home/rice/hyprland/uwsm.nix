{...}: {
  xdg.configFile."uwsm/env-hyprland".text = builtins.concatStringsSep "\nexport " [
    ""
    # AQ_NO_MODIFIERS=1
  ];
  xdg.configFile."hypr/xdph.conf".text = ''
    screencopy {
      allow_token_by_default = true
    }
  '';
  xdg.configFile."uwsm/env".text = builtins.concatStringsSep "\nexport " [
    ""
    "CLUTTER_BACKEND=wayland"
    "SDL_VIDEODRIVER=wayland"
    "QT_QPA_PLATFORM=wayland;xcb"
    "GDK_BACKEND=wayland,x11,*"

    "XCURSOR_THEME=Bibata-Modern-Classic"

    # Nvidia
    "LIBVA_DRIVER_NAME=nvidia"
    "GBM_BACKEND=nvidia-drm"
    "__GLX_VENDOR_LIBRARY_NAME=nvidia"
    "__GL_GSYNC_ALLOWED=0"
    "__GL_VRR_ALLOWED=0"
    "ELECTRON_OZONE_PLATFORM_HINT=auto"
    "NIXOS_OZONE_WL=1"
  ];
}
