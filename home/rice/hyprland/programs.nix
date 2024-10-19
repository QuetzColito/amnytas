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
          ''
        )
    ];
}
