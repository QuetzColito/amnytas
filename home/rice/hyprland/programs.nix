{
  pkgs,
  ...
} : {
    home.packages = with pkgs; [
        xorg.xrandr
        wf-recorder
        brightnessctl
        slurp
        grim
        hyprpicker
        grimblast
        bibata-cursors
        wl-clip-persist
        wl-clipboard
        xclip
        # pngquant
        # cliphist
        clipnotify
        playerctl
        pamixer
        pavucontrol
        pwvucontrol
        socat
        killall
        (writeShellScriptBin
          "handle_monitor_connect"
          ''
            handle() {
              case $1 in monitoradded*)
                hyprctl dispatch moveworkspacetomonitor "1 1"
                hyprctl dispatch moveworkspacetomonitor "2 1"
                hyprctl dispatch moveworkspacetomonitor "4 1"
                hyprctl dispatch moveworkspacetomonitor "5 1"
              esac
            }

            socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/\$\{HYPRLAND_INSTANCE_SIGNATURE\}/.socket2.sock" | while read -r line; do handle "$line"; done
          '')
        (writeShellScriptBin
          "pseudo-fullscreen"
          ''
            re='^[0-9]+$';
            id=$(hyprctl activeworkspace -j | jq .id | sed 's/"//g');
            name=$(hyprctl activeworkspace -j | jq .name | sed 's/"//g');
            if [[ $name =~ $re ]] ; then
                hyprctl dispatch renameworkspace $id pseudofullscreen;
                togglecurrentbar;
            else
                hyprctl dispatch renameworkspace $id $id;
                togglecurrentbar;
            fi
          '')
        (writeShellScriptBin
          "pauseshot"
          ''
            ${hyprpicker}/bin/hyprpicker -r -z &
            picker_proc=$!

            ${grimblast}/bin/grimblast save area - | tee ~/pics/ss$(date +'screenshot-%F') | wl-copy

            kill $picker_proc
          '')
        (writeShellScriptBin
          "pauseshotarea"
          ''
            ${hyprpicker}/bin/hyprpicker -r -z &
            picker_proc=$!

            grim -g \"$(slurp)\" - | wl-copy

            kill $picker_proc
          '')
    ];
}
