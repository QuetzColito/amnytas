{config, ...}: {
  hjem.users.${config.mainUser}.files.".config/foot/foot.ini".text = ''
    font=monospace:size=12

    [mouse]
    hide-when-typing=yes

    [colors]
    alpha=0.75
    background=${config.stylix.base16Scheme.base00}
    foreground=${config.stylix.base16Scheme.base05}
    # flash=7f7f00
    # flash-alpha=0.5

    ## Normal/regular colors (color palette 0-7)
    regular0=${config.stylix.base16Scheme.base04}  # black
    regular1=${config.stylix.base16Scheme.base08}  # red
    regular2=${config.stylix.base16Scheme.base0B}  # green
    regular3=${config.stylix.base16Scheme.base0A}  # yellow
    regular4=${config.stylix.base16Scheme.base0D}  # blue
    regular5=${config.stylix.base16Scheme.base0E}  # magenta
    regular6=${config.stylix.base16Scheme.base0C}  # cyan
    regular7=${config.stylix.base16Scheme.base06}  # white

    ## Bright colors (color palette 8-15)
    bright0=${config.stylix.base16Scheme.base04}   # bright black
    bright1=${config.stylix.base16Scheme.base08}   # bright red
    bright2=${config.stylix.base16Scheme.base0B}   # bright green
    bright3=${config.stylix.base16Scheme.base0A}   # bright yellow
    bright4=${config.stylix.base16Scheme.base0D}   # bright blue
    bright5=${config.stylix.base16Scheme.base0E}   # bright magenta
    bright6=${config.stylix.base16Scheme.base0C}   # bright cyan
    bright7=${config.stylix.base16Scheme.base06}   # bright white
  '';
}
