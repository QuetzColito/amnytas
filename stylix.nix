{
  pkgs,
  ...
} : {
  stylix = {
    fonts = {
      serif = {
        package = (pkgs.nerdfonts.override {fonts = ["Iosevka"];});
        name = "Iosevka";
      };

      sansSerif = {
        package = (pkgs.nerdfonts.override {fonts = ["Iosevka"];});
        name = "Iosevka";
      };

      monospace = {
        package = (pkgs.nerdfonts.override {fonts = ["Iosevka"];});
        name = "Iosevka Term";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    base16Scheme = {
      base01= "1A1B26";
      base00= "16161E";
      base02= "2F3549";
      base03= "444B6A";
      base04= "787C99";
      base05= "787C99";
      base06= "CBCCD1";
      base07= "D5D6DB";
      base08= "F7768E";
      base09= "FF9E64";
      base0A= "E0AF68";
      base0B= "41A6B5";
      base0C= "7DCFFF";
      base0D= "7AA2F7";
      base0E= "BB9AF7";
      base0F= "D18616";
    };

    image = ./wallpaper/main.jpg;

  };
}