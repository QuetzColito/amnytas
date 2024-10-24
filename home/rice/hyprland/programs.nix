{
  pkgs,
  config,
  ...
}: {
  # should be all the packages needed for the hyprland config
  # (cant be asked to write lib.meta.getExe pkgs.package everywhere)
  home.packages = with pkgs; [
    xorg.xrandr
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
    # the maximize script, toggles bar and renames the workspace so a special workspace rule will take effect
    (
      writeShellScriptBin "pseudo-fullscreen" ''
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
    (
      writeShellScriptBin "wf-recorder"
      "${config.agsCommand} -r recording.value=true; ${lib.meta.getExe wf-recorder} $@"
    )
    (
      writeShellScriptBin "stop-recording"
      "pkill --signal SIGINT wf-recorder & ${config.agsCommand} -r recording.value=false"
    )
  ];
}
