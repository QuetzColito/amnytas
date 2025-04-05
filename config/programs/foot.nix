{
  theme,
  pkgs,
  ...
}: {
  packages = [pkgs.foot];
  files.".config/foot/foot.ini".text = ''
    font=monospace:size=12

    [mouse]
    hide-when-typing=yes

    [colors]
    alpha=0.75
    background=${theme.base00}
    foreground=${theme.base05}
    # flash=7f7f00
    # flash-alpha=0.5

    ## Normal/regular colors (color palette 0-7)
    regular0=${theme.base04}  # black
    regular1=${theme.base08}  # red
    regular2=${theme.base0B}  # green
    regular3=${theme.base0A}  # yellow
    regular4=${theme.base0D}  # blue
    regular5=${theme.base0E}  # magenta
    regular6=${theme.base0C}  # cyan
    regular7=${theme.base06}  # white

    ## Bright colors (color palette 8-15)
    bright0=${theme.base04}   # bright black
    bright1=${theme.base08}   # bright red
    bright2=${theme.base0B}   # bright green
    bright3=${theme.base0A}   # bright yellow
    bright4=${theme.base0D}   # bright blue
    bright5=${theme.base0E}   # bright magenta
    bright6=${theme.base0C}   # bright cyan
    bright7=${theme.base06}   # bright white
  '';
}
