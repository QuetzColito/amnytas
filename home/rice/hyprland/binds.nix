{
  ...
}: let
  mod = "SUPER";
  modshift = "${mod}SHIFT";

  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10} (stolen from fufie)
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "${mod}, ${ws}, workspace, ${toString (x + 1)}"
        "${mod} SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);
in {
  wayland.windowManager.hyprland.settings = {
    bind =
      [
        # App Shortcuts
        "${mod},RETURN,exec,alacritty"
        "${mod},N,exec,thunar"
        "${mod},S,exec,codium"
        "${mod},Y,exec,for i in ~/MyGames/YTM/*.AppImage ; do appimage-run $i; done" # EXTERNAL DEPENDENCY
        "${mod},D,exec,flatpak run dev.vencord.Vesktop" # EXTERNAL DEPENDENCY

        "${mod},SPACE,exec,tofi-drun --drun-launch=true"
        "${mod},Q,killactive"
        "${mod},MINUS,exit"
        "${mod},BACKSPACE,exec,hyprctl kill"
        "${mod},P,pseudo"

        "${mod},H,movefocus,l"
        "${mod},L,movefocus,r"
        "${mod},K,movefocus,u"
        "${mod},J,movefocus,d"

        #",XF86Bluetooth, exec, bcn"
        "${mod},M,exec,hyprctl keyword $kw $(($(hyprctl getoption $kw -j | jaq -r '.int') ^ 1))" # toggle no_gaps_when_only
        "${mod},T,togglegroup," # group focused window
        "${mod},R,swapnext," # swap window
        "${modshift},G,changegroupactive," # switch within the active group
        "${mod},V,togglefloating," # toggle floating for the focused window
        "${mod},F,fullscreen," # fullscreen focused window

        # workspace controls
        "${modshift},right,movetoworkspace,+1" # move focused window to the next ws
        "${modshift},left,movetoworkspace,-1" # move focused window to the previous ws
        "${mod},right,workspace,+1" # move focus to the next ws
        "${mod},left,workspace,-1" # move focus to the previous ws
        "${mod},mouse_up,workspace,e+1" # move to the next ws
        "${mod},mouse_down,workspace,e-1" # move to the previous ws

        # new monitor key
        "${modshift},N,moveworkspacetomonitor,3 1"
        "${modshift},N,moveworkspacetomonitor,4 1"
        "${modshift},N,moveworkspacetomonitor,5 1"
        "${modshift},N,moveworkspacetomonitor,6 1"


        "CTRL ${modshift},S,exec, pauseshot"
        "${modshift},S,exec, grim -g \"$(slurp)\" - | wl-copy"
        "${modshift},O,exec,wl-ocr"

        "${modshift},L,exec,hyprlock"
      ]
      ++ workspaces;

    bindm = [
      "${mod},mouse:272,movewindow"
      "${mod},mouse:273,resizewindow"
    ];

    binde = [
      "SUPERALT, L, resizeactive, 80 0"
      "SUPERALT, H, resizeactive, -80 0"
    ];
    # binds that are locked, a.k.a will activate even while an input inhibitor is active
    bindl = [
      # media controls
      ",XF86AudioPlay,exec,playerctl play-pause"
      ",XF86AudioPrev,exec,playerctl previous"
      ",XF86AudioNext,exec,playerctl next"
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      #",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ];

  };
}