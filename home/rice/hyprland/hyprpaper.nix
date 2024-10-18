{
  config,
  pkgs,
  ...
} : let
        wallpapers = builtins.concatMap ({workspaces, name, ...} @ self :
            map (id: rec {
                inherit id;
                monitorID = name;
                path = if (self ? wallpaper) then "${name},${self.wallpaper}" else
                    "~/amnytas/wallpaper/${builtins.toString id}${if (self ? rotation) then "v" else ""}.png";
                command = "${monitorID},${path}";
            }) workspaces) config.monitors;
        wallpaperByMonitor = monitor: (builtins.head (builtins.filter ({monitorID, ...}: monitorID == monitor) wallpapers)).command;
    in {
    services.hyprpaper = {
        enable = true;
        settings = {
            splash = false;
            preload = map ({path, ...}: path) wallpapers;
            wallpaper = map ({name, ...}: wallpaperByMonitor name) config.monitors;
        };
    };

    home.packages = [
        (pkgs.writeShellScriptBin
            "hyprpaperswitch"
            ''socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock \
            | grep --line-buffered '^workspacev2>>' \
            | sed -ur 's/^.*>>|,.*$//g' \
            | while read line; do "hyprpaperswitchw$line"; done
            ''
        )
    ] ++ (map (
            {id, command, ...}: pkgs.writeShellScriptBin
                "hyprpaperswitchw${builtins.toString id}"
                "hyprctl hyprpaper wallpaper ${command}") wallpapers);
}
