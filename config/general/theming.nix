{
  config,
  theme,
  pkgs,
  ...
}: let
  gtk2conf = ''
    gtk-theme-name =  "${theme.gtk.name}"
    gtk-icon-theme-name = "${theme.icons.name}"
    gtk-font-name = "${theme.serif.name} 12"
    gtk-cursor-theme-name = "${theme.cursor.name}"
    gtk-cursor-theme-size = "${theme.cursor.size}"
  '';
  gtk3conf = ''
    [Settings]
    ${gtk2conf}
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
    pkgs.colloid-gtk-theme
  ];

  xdg.icons.fallbackCursorThemes = [theme.cursor.name];

  # Stealing from catppuccin makes theming easier
  environment.systemPackages = with pkgs; [darkly-qt5 darkly];
  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };
  files.".config/qt6ct/colors/base16.conf".text = with theme.colours; ''
    [ColorScheme]
    active_colors=#ff${base07}, #ff${base02}, #ff${base06}, #ff${base05}, #ff${base01}, #ff${base02}, #ff${base06}, #ff${base07}, #ff${base05}, #ff${base01}, #ff${base00}, #ff${base00}, #ff${base03}, #ff${base0E}, #ff${base0D}, #ff${base0C}, #ff${base02}, #ff${base05}, #ff${base01}, #ff${base06}, #8f${base04}
    disabled_colors=#ff${base07}, #ff${base02}, #ff${base06}, #ff${base05}, #ff${base01}, #ff${base02}, #ff${base04}, #ff${base05}, #ff${base04}, #ff${base00}, #ff${base00}, #ff${base00}, #ff${base03}, #ff${base0E}, #ff${base05}, #ff${base04}, #ff${base02}, #ff${base05}, #ff${base01}, #ff${base06}, #8f${base04}
    inactive_colors=#ff${base07}, #ff${base02}, #ff${base06}, #ff${base05}, #ff${base01}, #ff${base02}, #ff${base04}, #ff${base05}, #ff${base04}, #ff${base00}, #ff${base00}, #ff${base00}, #ff${base03}, #ff${base0E}, #ff${base05}, #ff${base04}, #ff${base02}, #ff${base05}, #ff${base01}, #ff${base06}, #8f${base04}
  '';
  files.".config/qt6ct/qt6ct.conf".text = ''
    [Appearance]
    color_scheme_path=${config.hjem.users.${config.mainUser}.directory}/.config/qt6ct/colors/base16.conf
    custom_palette=true
    standard_dialogs=default
    style=Darkly

    [Fonts]
    fixed="${theme.sansSerif.name},12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
    general="${theme.sansSerif.name},12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"

    [Interface]
    activate_item_on_single_click=1
    buttonbox_layout=0
    cursor_flash_time=1000
    dialog_buttons_have_icons=1
    double_click_interval=400
    gui_effects=General, AnimateMenu, AnimateCombo, AnimateTooltip, AnimateToolBox
    keyboard_scheme=2
    menus_have_icons=true
    show_shortcuts_in_context_menus=true
    stylesheets=@Invalid()
    toolbutton_style=4
    underline_shortcut=1
    wheel_scroll_lines=3
  '';

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

  programs.dconf.enable = true;
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
