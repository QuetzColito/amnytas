{theme, ...}: {
  files.".config/tofi/config".text = ''
    width = 100%
    height = 100%
    border-width = 0
    outline-width = 0
    padding-left = 35%
    padding-top = 35%
    result-spacing = 25
    num-results = 15
    font = ${theme.monospace.name}
    background-color = #0005
    selection-color = #7AA2F7
  '';
}
