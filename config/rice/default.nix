{
  pkgs,
  theme,
  ...
}: {
  imports = [
    ./hyprland
    ./mako.nix
    ./tofi.nix
    ./ags
  ];

  files = {
    # Ags colors
    ".config/stylix/colours.scss".text = builtins.concatStringsSep "\n" (builtins.attrValues (builtins.mapAttrs
      (name: value:
        "$"
        + "${name}: #${value};")
      theme.colours));
  };
  packages = with pkgs; [
    xorg.xrandr
    xorg.setxkbmap
    brightnessctl
    slurp
    grim
    hyprpicker
    hyprpolkitagent
    grimblast
    # bibata-cursors
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
      ''ags request startRecording; ${lib.getExe wf-recorder} "$@"''
    )
    (
      writeShellScriptBin "stop-recording"
      "pkill --signal SIGINT wf-recorder & ags request stopRecording"
    )

    tofi
    (writeShellScriptBin
      "my-tofi-run"
      "filter-tofi $(tofi-run --ascii-input true)")
  ];
}
