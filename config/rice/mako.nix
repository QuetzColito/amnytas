{
  pkgs,
  config,
  ...
}: {
  packages = [pkgs.mako];
  files.".config/mako/config".text = ''

    text-color=#${config.stylix.base16Scheme.base05}FF
    format=<b>%s</b>\n%b
    font=Inter

    background-color=#${config.stylix.base16Scheme.base01}CC
    height=150
    width=400
    margin=10
    padding=10

    border-color=#${config.stylix.base16Scheme.base0C}FF
    border-radius=0
    border-size=1

    max-icon-size=64

    group-by=none
    default-timeout=10000
    layer=overlay
    on-button-middle=dismiss-all
  '';
}
