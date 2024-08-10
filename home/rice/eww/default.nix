{
  pkgs,
  ...
} : let
    eww = "eww -c ~/nixos/home/rice/eww";
in {
    home.shellAliases.EWW = eww;
    home.packages = [
        pkgs.eww
        (pkgs.writeShellScriptBin
            "eww-timer"
            ''
            time=$1
            end="$(($(date +%s) + $time))"
            ${eww} update last-timer=$1
            ${eww} update timer-running=true
            while test "$(${eww} get timer-running)" = "true" && [ "$end" -ge `date +%s` ]
            do
                remaining=$(($end - `date +%s`))
                ${eww} update timer=$remaining
                sleep .5
            done
            if test "$(${eww} get timer-running)" = "true"
            then
                mpg123 ~/nixos/home/rice/eww/alert.mp3
                notify-send "A Timer has finished"
                ${eww} update timer-running=false
            fi
            ''
        )
        (pkgs.writeShellScriptBin
            "eww-cover-helper"
            ''
            playerctl -F metadata mpris:artUrl -i firefox | tee -a /tmp/ewwmprisurl | (
            while read -r line
            do
                curl -s "$(tail -n 1 /tmp/ewwmprisurl)" | magick - -resize 120x120 /tmp/ewwmpriscover
                ${eww} update mpris-art="/tmp/ewwmpriscover"
            done
            )
            ''
        )
        (pkgs.writeShellScriptBin
            "sound-down"
            ''
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
            ${eww} update volume=$(pamixer --get-volume-human)
            ''
        )
        (pkgs.writeShellScriptBin
            "sound-up"
            ''
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
            ${eww} update volume=$(pamixer --get-volume-human)
            ''
        )
        (pkgs.writeShellScriptBin
            "togglecurrentbar"
            ''
            ${eww} open --toggle bar-$(hyprctl activeworkspace -j | jq '.monitorID')
            ''
        )
        (pkgs.writeShellScriptBin
            "eww-change-active-workspace"
             ''
                function clamp {
                    min=$1
                    max=$2
                    val=$3
                    python -c "print(max($min, min($val, $max)))"
                }

                direction=$1
                current=$2
                if test "$direction" = "down"
                then
                    target=$(clamp 1 10 $(($current+1)))
                    echo "jumping to $target"
                    hyprctl dispatch workspace $target
                elif test "$direction" = "up"
                then
                    target=$(clamp 1 10 $(($current-1)))
                    echo "jumping to $target"
                    hyprctl dispatch workspace $target
                fi
             ''

        )
        (pkgs.writeShellScriptBin
            "eww-get-active-workspace"
             ''
                hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id'

                socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
                  stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}'
             ''
        )
        (pkgs.writeShellScriptBin
            "eww-get-workspaces"
             ''
                spaces (){
                    WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries')
                    seq 1 9 | jq --argjson windows "$WORKSPACE_WINDOWS" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})'
                }

                spaces
                socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
                    spaces
                done
             ''
        )
    ];
    wayland.windowManager.hyprland.settings = {
        exec-once = [
            "eww-cover-helper"
            "${eww} daemon"
            "${eww} open bar-0"
            "${eww} open bar-1"
            "${eww} open bar-2"
        ];
        bind = [
            "SUPER,E,exec,${eww} open --toggle widgets --screen $(hyprctl activeworkspace -j | jq '.monitorID')"
            "SUPERSHIFT,E,exec,${eww} open --toggle bar-$(hyprctl activeworkspace -j | jq '.monitorID')"
        ];
    };
}
