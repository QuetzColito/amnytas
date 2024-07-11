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
        "${mod},S,exec,alacritty --working-directory ~/nixos -e nvim ~/nixos"
        "${mod},G,exec,steam"
        "${mod},B,exec,firefox"
        "${mod},Y,exec,for i in ~/apps/ytm/*.AppImage ; do appimage-run $i; done" # EXTERNAL DEPENDENCY
        "${mod},D,exec,flatpak run dev.vencord.Vesktop" # EXTERNAL DEPENDENCY
        #"${mod},D,exec,vesktop"

        "${mod},SPACE,exec,hyprctl dispatch exec $(tofi-run --ascii-input true)"
        "${mod},Q,killactive"
        "${mod},MINUS,exit"
        "${mod},BACKSPACE,exec,hyprctl kill"
        "${mod},P,pseudo"

        "${mod},H,movefocus,l"
        "${mod},L,movefocus,r"
        "${mod},K,movefocus,u"
        "${mod},J,movefocus,d"

        #",XF86Bluetooth, exec, bcn"
        "${mod},R,swapnext," # swap window
        "${mod},V,togglefloating," # toggle floating for the focused window
        "${mod},F,fullscreen," # fullscreen focused window

        # workspace controls
        "${modshift},right,movetoworkspace,+1" # move focused window to the next ws
        "${modshift},left,movetoworkspace,-1" # move focused window to the previous ws
        "${mod},right,workspace,+1" # move focus to the next ws
        "${mod},left,workspace,-1" # move focus to the previous ws
        "${mod},mouse_up,workspace,e+1" # move to the next ws
        "${mod},mouse_down,workspace,e-1" # move to the previous ws
        "${modshift},mouse_up,movetoworkspace,+1" # move to the next ws
        "${modshift},mouse_down,movetoworkspace,-1" # move to the previous ws

        # new monitor key
        "${modshift},N,moveworkspacetomonitor,3 1"
        "${modshift},N,moveworkspacetomonitor,4 1"
        "${modshift},N,moveworkspacetomonitor,5 1"
        "${modshift},N,moveworkspacetomonitor,6 1"


        "CTRL ${modshift},S,exec, pauseshot"
        "${modshift},S,exec, grim -g \"$(slurp)\" - | wl-copy"

        "${modshift},L,exec,hyprlock"
      ]
      ++ workspaces;

    bindm = [
      "${mod},mouse:272,movewindow"
      "${mod},mouse:273,resizewindow"
    ];

    # binds that are locked, a.k.a will activate even while an input inhibitor is active
    bindl = [
      # media controls
      ",XF86AudioPlay,exec,playerctl play-pause"
      ",XF86AudioPrev,exec,playerctl previous"
      ",XF86AudioNext,exec,playerctl next"
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute,exec,playerctl play-pause" # remap epomaker knob to play/plause
      # ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ];

  };
}
