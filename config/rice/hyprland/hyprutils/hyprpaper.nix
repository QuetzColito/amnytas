{
  config,
  pkgs,
  hh,
  ...
}: let
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
  CmdByMonitor = monitor: (builtins.head (builtins.filter ({monitorID, ...}: monitorID == monitor) wallpapers)).command;
  PathByMonitor = monitor: (builtins.head (builtins.filter ({monitorID, ...}: monitorID == monitor) wallpapers)).path;
in {
  files.".config/hypr/hyprpaper.conf".text =
    ''
    ''
    + (hh.mkList "preload"
      (map ({name, ...}: PathByMonitor name)
        config.monitors))
    + (hh.mkList "wallpaper"
      (map ({name, ...}: CmdByMonitor name)
        config.monitors));

  packages = with pkgs;
    [
      hyprpaper
      # listens for workspace changes and then calls one of the scripts from below
      (
        writeShellScriptBin
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
          writeShellScriptBin
          "hyprpaperswitchw${builtins.toString id}"
          "hyprctl hyprpaper reload ${command}"
      )
      wallpapers);
}
