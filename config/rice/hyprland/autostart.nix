{
  hh,
  lib,
  config,
  ...
}: {
  options.autostartApps = lib.mkEnableOption "Autostart Desktop Apps";

  config.files = {
    ".config/hypr/autostart.conf".text = hh.mkList "exec-once" ([
        "uwsm finalize"
        "hyprlock --immediate; systemctl --user stop app-org.fcitx.Fcitx5@autostart.service"
        "hyprpaperswitch"
        "hyprpaper"
        config.agsCommand
        "systemctl --user start nm-applet"
        "systemctl --user enable --now hyprpolkitagent.service"
        "systemctl --user enable --now mako.service"
        "systemctl --user enable --now hypridle.service"
      ]
      ++ (
        if config.autostartApps
        then [
          "[workspace 7 silent] uwsm app -- zen"
          "[workspace 3 silent] uwsm app -- youtube-music"
          "[workspace 3 silent] uwsm app -- vesktop --enable-wayland-ime"
        ]
        else []
      ));
  };
}
