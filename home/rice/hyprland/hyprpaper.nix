{
  config,
  pkgs,
  ...
}: let
  # helper list that stores wallpaper and monitor per workspace
  wallpapers = builtins.concatMap ({
      workspaces,
      name,
      ...
    } @ self:
      map (id: rec {
        inherit id;
        monitorID = name;
        path =
          if (self ? wallpaper)
          then "${name},${self.wallpaper}"
          else "~/amnytas/wallpaper/${builtins.toString id}${
            if (self ? rotation)
            then "v"
            else ""
          }.png";
        command = "${monitorID},${path}";
      })
      workspaces)
  config.monitors;
  # function that takes a monitor and returns the first wallpaper
  wallpaperByMonitor = monitor: (builtins.head (builtins.filter ({monitorID, ...}: monitorID == monitor) wallpapers)).command;
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      # preload all wallpapers (does use a considerable amount of ram)
      preload = map ({path, ...}: path) wallpapers;
      # start with lowest workspace wallpaper (will get overridden instantly if you dont start on that ws)
      wallpaper = map ({name, ...}: wallpaperByMonitor name) config.monitors;
    };
  };

  home.packages =
    [
      # listens for workspace changes and then calls one of the scripts from below
      (
        pkgs.writeShellScriptBin
        "hyprpaperswitch"
        ''          socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock \
                      | grep --line-buffered '^workspacev2>>' \
                      | sed -ur 's/^.*>>|,.*$//g' \
                      | while read line; do "hyprpaperswitchw$line"; done
        ''
      )
      # this is a separate script for each workspace (a bit stupid yes, but it works :P)
    ]
    ++ (map (
        {
          id,
          command,
          ...
        }:
          pkgs.writeShellScriptBin
          "hyprpaperswitchw${builtins.toString id}"
          "hyprctl hyprpaper wallpaper ${command}"
      )
      wallpapers);
}
