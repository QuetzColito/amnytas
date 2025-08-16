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
        "noanim, launcher"
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
        "opacity 0.8, class: Brave-browser"
        "opacity 0.8, class:^firefox$, title:negative:^.*((Netflix)|(Twitch)|(YouTube)|(Crunchyroll.*)) —.*$"
        "opacity 0.8, class:^(chrome-).*$, title:negative:^.*((Netflix)|(Twitch)|(YouTube)|(Crunchyroll.*))$"
        # Disable all opacity when going fullscreen
        "opacity 1 override 1 override 1 override, fullscreen:1"

        # Make Steam start less annoying
        "noinitialfocus, title:^(Steam)$"

        # throw sharing indicators away
        "workspace special silent, title:^(Firefox — Sharing Indicator)$"
        "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

        "tag +game, class:^(steam_app.*)$"
        "tag +game, class:^(gamescope)$"
        "tag +game, class:^(moe\.launcher.*)$"
        "tag +game, class:^(starrail\.exe)$"
        "tag +game, class:^(ffxiv_dx11\.exe)$"
        "tag +game, class:codium-url-handler"
        "tag +game, class:^(genshinimpact\.exe)$"
        "tag +game, class:^(moe\.launcher\.an-anime-game-launcher)$"
        "float, class:^(moe\.launcher\.an-anime-game-launcher)$"
        # Some games dont like not being rendered
        "renderunfocused, tag:game"
        # Lets see if i get crashes again
        "immediate, tag:game"

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

        "tag +bhud, title:(Blish HUD)"
        "float, tag:bhud"
        "center, tag:bhud"
        "nofocus, tag:bhud"
        "noinitialfocus, tag:bhud"
        "noborder, tag:bhud"
        "pin, tag:bhud"
        "opacity 0.2 0.2, tag:bhud"
        "workspace 6 silent, tag:bhud"
        "forcergbx, tag:bhud"

        "stayfocused, title:(Guild Wars 2)"

        "scrollmouse 10, class:^(genshinimpact\.exe)$"

        # organization
        "workspace 3, class:^(vesktop)$"
        "workspace 3, class:^(com.github.th_ch.youtube_music)$"
        "workspace 9, title:^(Steam)$"
        "workspace 6, tag:game"
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
