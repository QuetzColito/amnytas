{
  pkgs,
  theme,
  ...
}: {
  packages = [pkgs.mako];
  files.".config/mako/config".text = ''

    text-color=#${theme.base05}FF
    format=<b>%s</b>\n%b
    font=Inter

    background-color=#${theme.base01}CC
    height=150
    width=400
    margin=10
    padding=10

    border-color=#${theme.base0C}FF
    border-radius=0
    border-size=1

    max-icon-size=64

    group-by=none
    default-timeout=10000
    layer=overlay
    on-button-middle=dismiss-all
  '';
}
