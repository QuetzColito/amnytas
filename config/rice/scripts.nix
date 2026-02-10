{pkgs, ...}: {
  packages = with pkgs; [
    # the maximize script, toggles bar and renames the workspace so a special workspace rule will take effect
    (
      writeShellScriptBin "pseudo-fullscreen" ''
        re='^[0-9]+$';
        id=$(hyprctl activeworkspace -j | jq .id | sed 's/"//g');
        name=$(hyprctl activeworkspace -j | jq .name | sed 's/"//g');
        if [[ $name =~ $re ]] ; then
            hyprctl dispatch renameworkspace $id pseudofullscreen;
            togglecurrentbar
        else
            hyprctl dispatch renameworkspace $id $id;
            togglecurrentbar
        fi
      ''
    )
    (
      writeShellScriptBin "toggle" ''
        exists=$(hyprctl workspaces -j | jq "map(.name) | contains([\"special:toggle$1\"])")
        hyprctl dispatch togglespecialworkspace toggle$1

        [ "$exists" = "true" ] && exit

        # spawn terminal
        hyprctl dispatch exec "[workspace special:toggle$1] $1"

        # ensure focus
        socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | grep -q "openwindow>>.*,.*,$2.*"
        hyprctl dispatch focuswindow address:$(hyprctl clients -j | jq -r "map(select(.workspace.name == \"special:toggle$1\"))[0].address")
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
    (writeShellScriptBin
      "quetzclicker"
      "while true; do ydotool click 0xC0; done")
    (writeShellScriptBin
      "gw2-discomarker"
      "ydotool key 42:0 125:0 56:1 2:1 2:0 3:1 3:0 4:1 4:0 5:1 5:0 6:1 6:0 7:1 7:0 8:1 8:0 8:1 9:0 56:0")
    (writeShellScriptBin "flip" ''
      activemon=$(hyprctl activeworkspace -j | jq -r '.monitor')
      transform=$((($(hyprctl monitors -j | jq ".[] | select(.name==\"$activemon\").transform") + 2) % 4))
      hyprctl keyword monitor "$activemon,preferred,auto,1,transform,$transform"
      hyprctl keyword input:touchdevice:transform "$transform"
    '')
    (writeShellScriptBin "workspace-direction" ''
      sorted=$(hyprctl monitors -j | jq "sort_by(.x) | map(.name)")
      len=$(echo $sorted | jq length)
      activeIndex=$(echo $sorted | jq "index($(hyprctl activeworkspace -j | jq .monitor))")
      next=$((($activeIndex $1 1) % $len))
      nextName=$(echo $sorted | jq ".[$next]")

      hyprctl dispatch workspace $(hyprctl monitors -j | jq "map(select(.name == $nextName)) | .[0] | .activeWorkspace.id")
    '')
  ];
}
