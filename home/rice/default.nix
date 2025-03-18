{config, ...}: {
  imports = [
    ./hyprland
    ./tofi.nix
    ./ags
    ./mako.nix
  ];

  #YTM colours
  xdg.configFile."stylix/ytm.css".text =
    builtins.concatStringsSep "\n"
    ([
        "html:not(.style-scope) {"
      ]
      ++ (builtins.attrValues (builtins.mapAttrs
        (name: value: "  --${name}: #${value};")
        config.stylix.base16Scheme)))
    + (import ./ytm.nix);

  # Ags colors
  xdg.configFile."stylix/colours.scss".text = builtins.concatStringsSep "\n" (builtins.attrValues (builtins.mapAttrs
    (name: value:
      "$"
      + "${name}: #${value};")
    config.stylix.base16Scheme));
}
