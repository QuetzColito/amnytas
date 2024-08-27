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
            wallpaper = map ({wallpaper, name, ...}: name + "," + wallpaper) config.monitors;
        };
    };
}
