{
  config,
  lib,
  ...
} : let
    toHex = s: lib.strings.concatStrings [ "#" s ];
in {
    programs.yazi = {
        enable = true;

        keymap = {

        };

        settings = {

        };

        theme.manager.hovered = lib.mkForce {
            bg = toHex config.stylix.base16Scheme.base02;
            bold = true;
            fg = toHex config.stylix.base16Scheme.base0E;
        };
    };
}
