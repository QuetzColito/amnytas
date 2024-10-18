{
  pkgs,
  ...
} : {
    home = {
        stateVersion = "23.11"; # Please read the comment before changing.

        packages = with pkgs; [
            (writeShellScriptBin "popvm" "quickemu --vm ~/storage/pop/popos-22.04-intel.conf")
        ];
    };

    programs.git.extraConfig.user = {
        email = "stefan.lahne@proton.me";
        name = "Stefan Lahne";
    };

    monitors = [
        {
            name = "DP-1";
            coords = "-1080x50";
            rotation = "1";
            workspaces = [ 1 2 3 ];
        }
        {
            name = "HDMI-A-1";
            coords = "2560x660";
            workspaces = [ 7 8 9 ];
        }
        {
            name = "DP-2";
            coords = "0x0";
            workspaces = [ 4 5 6 ];
        }
    ];

    wayland.windowManager.hyprland = {
        settings = {
            exec-once = [
            "[workspace 7 silent] zen"
            "[workspace 3 silent] for i in ~/apps/ytm/*.AppImage ; do appimage-run $i; done" # EXTERNAL DEPENDENCY
            "[workspace 3 silent] vesktop --enable-wayland-ime"
              "sleep 5; hyprctl dispatch resizewindowpixel exact 100% 30%,YouTube"
            ];
        };
    };
}
