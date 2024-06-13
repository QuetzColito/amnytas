{
  pkgs,
  ...
} : {
  stylix = {
    enable = true;

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.fira-code-nerdfont;
        name = "FiraCode Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    cursor.size = 24;
    opacity.terminal = 0.75;
    base16Scheme = {
      base01= "1A1B26"; # Default Background
      base00= "16161E"; # Lighter Background
      base02= "2F3549"; # Selection Background
      base03= "444B6A"; # Comments - Invisibles
      base04= "787C99"; # Dark Foreground
      base05= "787C99"; # Default Foreground
      base06= "CBCCD1"; # Light Foreground
      base07= "D5D6DB"; # Light Background
      base08= "F7768E"; # Red # Variables, XML Tags, Markup Link/Lists 
      base09= "FF9E64"; # Orange # Ints, Bools, Consts, XML Attrs, Markup link url
      base0A= "E0AF68"; # Yellow # Classes, Markup bold, Search Text Background
      base0B= "9ECE6A"; # Green # Strings, Inherited Class, Markup Code, Diff Inserted
      base0C= "7DCFFF"; # Cyan # Support, Regular Expressions, Escape Characters, Markup Quotes
      base0D= "7AA2F7"; # Blue # Functions, Methods, Attribute IDs, Headings
      base0E= "BB9AF7"; # Purple # Keywords, Storage, Selector, Markup Italic, Diff Changed
      base0F= "D18616"; # Dark Orange # Deprecated, Opening/Closing Embedded Language Tags
    };

    image = ./wallpaper/main.jpg;

  };

}