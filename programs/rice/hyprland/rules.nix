{
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "blur, ^(gtk-layer-shell)$"
      "blur, ^(launcher)$"
      "ignorezero, ^(gtk-layer-shell)$"
      "ignorezero, ^(launcher)$"
      "blur, notifications"
      "ignorezero, notifications"
      "blur, bar"
      "ignorezero, bar"
      "ignorezero, ^(gtk-layer-shell|anyrun)$"
      "blur, ^(gtk-layer-shell|anyrun)$"
      "noanim, launcher"
      "noanim, bar"
    ];
    windowrulev2 = [
      # only allow shadows for floating windows
      "noshadow, floating:0"
      "tile, title:Spotify"

      # OWOPACITY
      "opacity 0.85, class:codium-url-handler"
      "forcergbx, class:codium-url-handler"
      "noblur, class:Alacritty"
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
      "opacity 0.8 0.8 1, class: firefox"
      "opacity 1 override 1 override 1 override ,title:^(.*YouTube — Mozilla Firefox)|(.*Crunchyroll — Mozilla Firefox)$"


      # imported stuff
      "idleinhibit focus, class:^(mpv)$"
      "idleinhibit focus,class:foot"
      "idleinhibit fullscreen, class:^(firefox)$"

      "float, class:^(org.gnome.Loupe)$"
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      "float,class:udiskie"

      #"workspace special silent,class:^(pavucontrol)$"

      "float, class:^(imv)$"

      # throw sharing indicators away
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

      "workspace 1, class:^(vesktop)$"
      "workspace 1, class:^(YouTube Music)$"
      "workspace 7, class:^(firefox)"
      "workspace 4, class:^(steam_app.*)$"
      "workspace 9, title:^(Steam)$"
    ];
  };
}
