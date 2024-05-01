{
  pkgs,
  ...
}: let
  tofi-emoji = pkgs.writeShellScriptBin "tofi-emoji" ''
    #!/bin/sh
    cat ${./emojis} | tofi --prompt-text "Emoji: " | awk '{print $1}' | tr -d '\n' | tee >(wl-copy) >(xargs -I % notify-send "% Emoji" "Emoji copied to clipboard")
  '';
in {
  home.packages = [pkgs.tofi tofi-emoji];
  xdg.configFile."tofi/config".text = ''
    height = 100%
    width = 100%
    padding-left = 30%
    padding-top = 30%
    anchor = center
    border-width = 0
    outline-width = 0
    result-spacing = 25
    num-results = 0
    font = monospace
    background-color = #1A1B2630
    selection-color = #7AA2F7
  '';
}

    #anchor = center
    #width = 500
    #height = 300
    #horizontal = false
    #font-size = 14
    #prompt-text = "Run "
    #font = monospace
    #ascii-input = false
    #outline-width = 5
    #outline-color = #414559
    #border-width = 2
    #border-color = #7da6ff
    #background-color = #303446
    #text-color = #c6d0f5
    #selection-color = #7da6ff
    #min-input-width = 120
    #late-keyboard-init = true
    #result-spacing = 10
    #padding-top = 15
    #padding-bottom = 15
    #padding-left = 15
    #padding-right = 15
    #width = 100%