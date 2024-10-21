{
  pkgs,
  ...
} : {
    home = {
        stateVersion = "23.11"; # Please read the comment before changing.

        packages = with pkgs; [
            (writeShellScriptBin "popvm" "quickemu --vm ~/storage/pop/popos-22.04-intel.conf")
            # This still doesnt work consistently, no idea how to do it better
            (writeShellScriptBin "resize-ytm"
            ''
                count=0

                socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock \
                | grep --line-buffered '^openwindow' \
                | stdbuf -oL cut -d',' -f2 \
                | while read -r line; do
                    if [[ "$line" == "3" ]]; then
                        ((count++))
                    fi

                    if [[ $count -eq 3 ]]; then
                        hyprctl dispatch focuswindow YouTube
                        hyprctl dispatch swapnext
                        hyprctl dispatch resizeactive exact 100% 30%
                        exit 0
                    fi
                done
            '')
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

    # some autostarts
    wayland.windowManager.hyprland = {
        settings = {
            exec-once = [
                "resize-ytm"
                "[workspace 7 silent] zen"
                "[workspace 3 silent] youtubemusic" # EXTERNAL DEPENDENCY
                "[workspace 3 silent] vesktop --enable-wayland-ime"
            ];
        };
    };
}
