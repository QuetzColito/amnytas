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
  xdg.configFile."tofi/config".text = 
  #''
  #  height = 100%
  #  width = 100%
  #  padding-left = 30%
  #  padding-top = 30%
  #  anchor = center
  #  border-width = 0
  #  outline-width = 0
  #  result-spacing = 25
  #  num-results = 0
  #  font = monospace
  #  background-color = #1A1B2630
  #  selection-color = #7AA2F7
  #'';
  ''
    width = 100%
    height = 100%
    border-width = 0
    outline-width = 0
    padding-left = 35%
    padding-top = 35%
    result-spacing = 25
    num-results = 15
    font = monospace
    background-color = #0005
    selection-color = #7AA2F7
  '';
}