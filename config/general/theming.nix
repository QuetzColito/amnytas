{
  config,
  theme,
  pkgs,
  ...
}: let
  gtk2conf = ''
    gtk-theme-name =  "${theme.gtk.name}"
    gtk-icon-theme-name = "${theme.icons.name}"
    gtk-font-name = "${theme.serif.name} 12";
    gtk-cursor-theme-name = "${theme.cursor.name}"
    gtk-cursor-theme-size = "${theme.cursor.size}"
  '';
  gtk3conf = ''
    [Settings]
    gtk-theme-name = ${theme.gtk.name}
    gtk-icon-theme-name = ${theme.icons.name}
    gtk-font-name = "${theme.serif.name} 12";
    gtk-cursor-theme-name = ${theme.cursor.name}
    gtk-cursor-theme-size = ${theme.cursor.size}
  '';
  gtk4css = ''
    * {all: unset;}
    @import url("/etc/profiles/per-user/${config.mainUser}/share/themes/${theme.gtk.name}/gtk-4.0/gtk.css");
  '';
in {
  # fonts, dont remove the cjk one or kana will look ugly
  fonts.packages = with pkgs;
    [
      noto-fonts-cjk-sans
      material-icons
      material-design-icons
      roboto
    ]
    ++ theme.fonts;

  fonts.fontconfig.defaultFonts = {
    serif = [theme.serif.name];
    sansSerif = [theme.sansSerif.name];
    monospace = [theme.monospace.name];
    emoji = [theme.emoji.name];
  };

  packages = [
    theme.cursor.package
    theme.gtk.package
    theme.icons.package
  ];

  xdg.icons.fallbackCursorThemes = [theme.cursor.name];

  # this was easier than expected :D (I don't heavily use qt apps so dont care if it isnt perfect)
  qt = {
    enable = true;
    style = "gtk2";
    platformTheme = "gtk2";
  };

  # Applying the Theme to as many places as possible >.>
  # The main one used are apparently the dconf settings and GTK_THEME
  # I read on reddit that setting GTK_THEME breaks libadwaita apps, but didnt have issues yet
  environment = {
    etc."xdg/gtk-2.0/gtkrc".text = gtk2conf;
    etc."xdg/gtk-3.0/settings.ini".text = gtk3conf;
    sessionVariables = {
      GTK2_RC_FILES = "/home/${config.mainUser}/.gtkrc-2.0";
      GTK_THEME = theme.gtk.name;
    };
  };

  files = {
    ".gtkrc-2.0".text = gtk2conf;
    ".config/gtk-3.0/settings.ini".text = gtk3conf;
    ".config/gtk-4.0/settings.ini".text = gtk3conf;
    ".config/gtk-4.0/gtk.css".text = gtk4css;
  };

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
