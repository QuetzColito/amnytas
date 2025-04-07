{
  config,
  theme,
  pkgs,
  ...
}: {
  # fonts, dont remove the cjk one or kana will look ugly
  fonts.packages = with pkgs;
    [
      noto-fonts-cjk-sans
      material-icons
      material-design-icons
      roboto
    ]
    ++ theme.fonts;

  # TODO: Somewhere KDE has set my font and i cant find out where to overwrite it x.x

  # Applying the Theme to as many places as possible >.>
  # The main one used are apparently the dconf settings and GTK_THEME set in usmw/env
  fonts.fontconfig.defaultFonts = {
    serif = [theme.serif.name];
    sansSerif = [theme.sansSerif.name];
    monospace = [theme.monospace.name];
    emoji = [theme.emoji.name];
  };
  environment.etc."xdg/gtk-2.0/gtkrc".text = ''
    gtk-theme-name =  "${theme.gtk.name}"
    gtk-icon-theme-name = "${theme.icons.name}"
    gtk-cursor-theme-name = "${theme.cursor.name}"
    gtk-cursor-theme-size = "${theme.cursor.size}"
  '';

  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name = ${theme.gtk.name}
    gtk-icon-theme-name = ${theme.icons.name}
    gtk-cursor-theme-name = ${theme.cursor.name}
    gtk-cursor-theme-size = ${theme.cursor.size}
  '';
  hjem.users.${config.mainUser}.rum.gtk = {
    enable = true;
    packages = [
      theme.cursor.package
      theme.gtk.package
      theme.icons.package
    ];
    settings = {
      theme-name = theme.gtk.name;
      icon-theme-name = theme.icons.name;
      # font-name = "${theme.serif.name} 12";
      cursor-theme-name = theme.cursor.name;
      cursor-theme-size = theme.cursor.size;
    };
    # Not sure if this works, but something needs to be done with those files
    css.gtk4 = ''
      * {all: unset;}
      @import url("/etc/profiles/per-user/${config.mainUser}/share/themes/${theme.gtk.name}/gtk-4.0/gtk.css");
    '';
  };

  xdg.icons.fallbackCursorThemes = [theme.cursor.name];

  programs.dconf.profiles.user = {
    databases = [
      {
        lockAll = true;
        settings = {
          "org/gnome/desktop/interface" = {
            gtk-theme = theme.gtk.name;
            color-scheme = "prefer-dark";
            icon-theme = theme.icons.name;
            font-name = "${theme.serif.name}, 12";
            monospace-font-name = "${theme.monospace.name}, 12";
            cursor-theme = theme.cursor.name;
            cursor-size = theme.cursor.size;
          };
          "org/gnome/shell/extensions/user-theme" = {
            inherit (theme.gtk) name;
          };
        };
      }
    ];
  };
}
