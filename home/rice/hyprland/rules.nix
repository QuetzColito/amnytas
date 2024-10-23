{...}: {
  wayland.windowManager.hyprland.settings = {
    layerrule = [
      # layers are things like the widgets, wallpaper, bar and launcher (basically everything that isnt a window)
      # they can be on 4 levels, 2 above the windows and 2 below
      "xray 0, launcher"
      "ignorezero, launcher"
      "noanim, launcher"
      "xray 0, bar"
      "blur, bar"
      "ignorezero, bar"
      "noanim, bar"
      "blur, notifications"
      "ignorezero, notifications"
    ];
    windowrulev2 = [
      # why wouldnt you wanna tile >.>
      "tile, class:^DesktopEditors$"
      "tile, class:^pobfrontend$"

      # OWOPACITY
      "opacity 0.85, class:codium-url-handler"
      "forcergbx, class:codium-url-handler"
      "noblur, class:Alacritty"
      "noblur, class:^kitty$"
      "noblur, class:^foot$"
      "opacity 0.85, title:^(.*Thunar.*)$"
      "forcergbx, title:^(.*Thunar.*)$"
      "opacity 0.85, class:^file-roller$"
      "forcergbx, class:^file-roller$"
      "opacity 0.95, title:^(.*Discord.*)$"
      "forcergbx, title:^(.*Discord.*)$"
      "opacity 0.9, class:^steam$"
      "forcergbx, class:^steam$"
      "opacity 0.95, class:^(YouTube Music)$"
      "forcergbx, class:^(YouTube Music)$"
      "opacity 0.8, class: firefox"
      "opacity 0.8, title: ^(.*Zen Browser)$"
      # Disable opacity when watching videos
      "opacity 1 override 1 override 1 override ,title:^(.*YouTube — Mozilla Firefox)|(.*Crunchyroll.* — Mozilla Firefox)$"
      "opacity 1 override 1 override 1 override ,title:^(.*YouTube — Zen Browser)|(.*Crunchyroll.* — Zen Browser)$"
      # Disable all opacity when going fullscreen
      "opacity 1 override 1 override 1 override ,fullscreen:1"

      "float, class:^(org.gnome.Loupe)$"
      "float, class:^(vlc)$"
      "float, class:^(xdg-desktop-portal-gtk)$"
      "float, class:^(moe.launcher.the-honkers-railway-launcher)$"
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      "float, class:^(imv)$"
      "noinitialfocus, title:^(Steam)$"

      # throw sharing indicators away
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

      # organization
      "workspace 3, class:^(vesktop)$"
      "workspace 3, class:^(YouTube Music)$"
      "workspace 9, title:^(Steam)$"
      "workspace 6, class:^(steam_app.*)$"
      "workspace 6, class:^(gamescope)$"
      "workspace 6, class:^(moe\.launcher.*)$"
      "workspace 6, class:^(starrail\.exe)$"
      # make starrail not freeze in the background
      "renderunfocused, class:^(starrail\.exe)$"
      "workspace 5, class:codium-url-handler"
      # dont think this actually works
      "tile, class:^(steam_app.*)$"
    ];

    workspace = [
      "name:pseudofullscreen, gapsout:0, rounding:false, bordersize:0"
    ];
  };
}
