{
  hh,
  config,
  ...
}: {
  files = {
    ".config/hypr/rules.conf".text =
      hh.mkList "layerrule" [
        # layers are things like the widgets, wallpaper, bar and launcher (basically everything that isnt a window)
        # they can be on 4 levels, 2 above the windows and 2 below
        "xray 0, launcher"
        "ignorezero, launcher"
        "noanim, launcher"
        "xray 0, bar"
        # "noblur, bar"
        "ignorezero, bar"
        "noanim, bar"
        "blur, notifications"
        "ignorezero, notifications"
      ]
      + hh.mkList "windowrule" [
        # why wouldnt you wanna tile >.>
        "tile, class:^DesktopEditors$"
        "tile, class:^pobfrontend$"
        "tile, class:^(steam_app.*)$"
        "fullscreen, class:^osu!$"
        "float, class:^(vlc)$"
        "float, class:^(imv)$"
        "float, class:^(mpv)$"
        "float, class:^(floatfoot)$"
        "float, class:^(xdg-desktop-portal-gtk)$"
        "float, class:^(moe.launcher.the-honkers-railway-launcher)$"
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"

        "suppressevent maximize,class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        # OWOPACITY
        "opacity 0.85, class:codium-url-handler"
        "forcergbx, class:codium-url-handler"
        "noblur, class:^foot$"
        "opacity 0.85, title:^(.*Thunar.*)$"
        "forcergbx, title:^(.*Thunar.*)$"
        "opacity 0.85, class:^file-roller$"
        "forcergbx, class:^file-roller$"
        "opacity 0.95, title:^(.*Discord.*)$"
        "forcergbx, title:^(.*Discord.*)$"
        "opacity 0.9, class:^steam$"
        "forcergbx, class:^steam$"
        "opacity 0.95, class:^(com.github.th_ch.youtube_music)$"
        "forcergbx, class:^(com.github.th_ch.youtube_music)$"
        "opacity 0.8, class: firefox"
        "opacity 0.8, class: Brave-browser"
        "opacity 0.8, title: ^(.*Zen Browser)$"
        # Disable opacity when watching videos
        "opacity 1 override 1 override 1 override ,title:^(.*Twitch — Mozilla Firefox)|(.*YouTube — Mozilla Firefox)|(.*Crunchyroll.* — Mozilla Firefox)$"
        "opacity 1 override 1 override 1 override ,title:^(.*Twitch — Zen Browser)|(.*YouTube — Zen Browser)|(.*Crunchyroll.* — Zen Browser)$"
        # Disable all opacity when going fullscreen
        "opacity 1 override 1 override 1 override ,fullscreen:1"

        # Make Steam start less annoying
        "noinitialfocus, title:^(Steam)$"

        # throw sharing indicators away
        "workspace special silent, title:^(Firefox — Sharing Indicator)$"
        "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

        # organization
        "workspace 3, class:^(vesktop)$"
        "workspace 3, class:^(com.github.th_ch.youtube_music)$"
        "workspace 9, title:^(Steam)$"
        "workspace 6, class:^(steam_app.*)$"
        "workspace 6, class:^(gamescope)$"
        "workspace 6, class:^(moe\.launcher.*)$"
        "workspace 6, class:^(starrail\.exe)$"
        "workspace 6, class:^(ffxiv_dx11\.exe)$"
        "workspace 5, class:codium-url-handler"

        # Overlays are the bane of my existence x.x
        "tag +poe, title:(Path of Exile)"
        "tag +poe, class:(steam_app_238960)"
        "fullscreen, tag:poe"

        "tag +apt, title:(Awakened PoE Trade)"
        "float, tag:apt "
        "noblur, tag:apt"
        "nofocus, tag:apt # Disable auto-focus"
        "noshadow, tag:apt"
        "noborder, tag:apt"
        "pin, tag:apt"
        "renderunfocused, tag:apt"
        "size 100% 100%, tag:apt"
        "center, tag:apt"

        # make starrail not freeze in the background
        "renderunfocused, class:^(starrail\.exe)$"
        # "immediate, class:^(starrail\.exe)$"
        "renderunfocused, class:^(steam_app.*)$"
        # "immediate, class:^(steam_app.*)$"
        "renderunfocused, class:^(ffxiv_dx11\.exe)$"
        # "immediate, class:^(ffxiv_dx11\.exe)$"
      ]
      + hh.mkList "workspace" ([
          "name:pseudofullscreen, gapsin:0, gapsout:0, rounding:false, bordersize:0"
        ]
        ++ (builtins.concatLists (
          map (
            {
              workspaces,
              name,
              ...
            }:
              map (ws: "${builtins.toString ws}, monitor:${name}") workspaces
          )
          config.monitors
        )));
  };
}
