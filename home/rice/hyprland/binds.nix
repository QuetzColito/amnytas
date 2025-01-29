{config, ...}: let
  mod = "SUPER";
  modshift = "${mod}SHIFT";

  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10} (stolen from fufie)
  # (stolen from sioodmy :P) although i dont really use ws 10
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
        # App Launcher (only scans executables, cant be bothered with desktop entries)
        # my-tofi-run is defined in tofi.nix and adds foot if package is in tuiPackages
        "${mod},SPACE,exec,uwsm app -- $(my-tofi-run)"
        # Terminal
        "${mod},RETURN,exec,foot"
        # Settings
        "${mod},S,exec,[workspace 5] uwsm app -- foot -D ~/amnytas nvim ~/amnytas"
        # File Manager
        "${mod},N,exec,foot yazi"
        # Gaming
        "${mod},G,exec,[workspace 9 silent] steam"
        # Browser
        "${mod},B,exec,[workspace 7] zen"
        # Alt Browser
        "${modshift},B,exec,[workspace 8] brave"
        # Music Player
        "${mod},Y,exec,YouTube-Music" # EXTERNAL DEPENDENCY
        # Discord
        "${mod},D,exec,vesktop --enable-wayland-ime"
        # Windows Task Manager keybind cause why not
        "CTRL ALT,DELETE,exec,foot btop -p 0"
        # Toggle Japanese Input
        "${mod},I,exec,killall -r fcitx5 || fcitx5"
        # Having mozc running in the background blocks mouse2+`
        # which is a problem for gaming,
        # so i only activate when i need it and have mozc as my only layout in fcitx5

        # Sometimes copy between wayland and xwayland bugged out, pressing this helped
        # (basically just re-copies your clipboard)
        "${mod},C,exec,wl-paste | wl-copy"

        # Window Management
        # Quit Window (i was a mac person once :P)
        "${mod},Q,killactive"
        # Kill the next Window you click (when quit doesnt work)
        "${mod},BACKSPACE,exec,hyprctl kill"
        # Kill Hyprland, was more useful without greetd
        "${mod},MINUS,exit"

        # Open Special Workspace
        "${mod},Z,togglespecialworkspace"
        # Open Widgets
        "${mod},E,exec,ags request toggleDashboard"
        # Toggle Bar on current monitor
        "${modshift},E,exec,togglecurrentbar"

        # move focus with hjkl
        "${mod},H,movefocus,l"
        "${mod},L,movefocus,r"
        "${mod},K,movefocus,u"
        "${mod},J,movefocus,d"
        # switch workspace with HL
        "${modshift},H,workspace,-1"
        "${modshift},L,workspace,+1"
        # switch workspace and take window with you with JK
        "${modshift},K,movetoworkspace,-1"
        "${modshift},J,movetoworkspace,+1"

        #",XF86Bluetooth, exec, bcn"
        "${mod},R,swapnext," # swap window
        "${mod},V,togglefloating," # toggle floating for the focused window
        "${mod},F,fullscreen," # fullscreen focused window

        # disable gaps and borders on current workspace and disable bar on the current monitor,
        # practically makes a tiled window fullscreen. shouldve probably called it maximize xD
        "${modshift},F,exec,pseudo-fullscreen"

        # workspace controls
        "${modshift},right,movetoworkspace,+1" # move focused window to the next ws
        "${modshift},left,movetoworkspace,-1" # move focused window to the previous ws
        "${mod},right,workspace,+1" # move focus to the next ws
        "${mod},left,workspace,-1" # move focus to the previous ws
        "${mod},mouse_up,workspace,e+1" # move to the next ws
        "${mod},mouse_down,workspace,e-1" # move to the previous ws
        "${modshift},mouse_up,movetoworkspace,+1" # move to the next ws
        "${modshift},mouse_down,movetoworkspace,-1" # move to the previous ws

        # recording
        ''${modshift},X,exec,wf-recorder -y -f ~/Videos/wf-recording.mp4 -g "$(slurp)"''
        ''CTRL ${mod},X,exec,wf-recorder -y -f ~/Videos/wf-recording.mp4 -g "$(slurp -o)"''
        # stop recording
        "${mod},X,exec,stop-recording"

        # Screenshots
        "${modshift},S,exec, grimblast copy area"
        "CTRL ${modshift},S,exec, grimblast --freeze copy area"
        "CTRL ${mod},S,exec, grimblast --freeze copy output"

        # Color Picker
        "${modshift},C,exec, hyprpicker | wl-copy"
      ]
      # see above
      ++ workspaces;

    bindm = [
      # Mouse Controls
      "${mod},mouse:272,movewindow"
      "${mod},mouse:273,resizewindow"
    ];

    # binds that are locked, a.k.a will activate even while an input inhibitor is active (like hyprlock)
    bindl = [
      # media controls
      ",XF86AudioPlay,exec,playerctl play-pause"
      ",XF86AudioPrev,exec,playerctl previous"
      ",XF86AudioNext,exec,playerctl next"
      ",XF86AudioRaiseVolume, exec, sound-up"
      ",XF86AudioLowerVolume, exec, sound-down"
      ",XF86AudioMute,exec,playerctl play-pause" # remap epomaker knob to play/plause
      # ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ];
  };
  # Disable all keybinds with mod U until you press it again (useful when using a vm)
  wayland.windowManager.hyprland.extraConfig = ''
    bind = ${mod},U,submap,immersive

    submap = immersive
    bind = ${mod},U,submap,reset
    submap = reset
  '';
}
