{
  config,
  ...
} : {
    services.hyprpaper = {
        enable = true;
        settings = {
            splash = false;
            ipc = "off";
            preload = map ({wallpaper, ...}: wallpaper) config.monitors;
            wallpaper = map ({wallpaper, id, ...}: id + "," + wallpaper) config.monitors;
        };
    };
}
