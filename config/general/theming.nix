{
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

  fonts.fontconfig.defaultFonts = {
    serif = [theme.serif.name];
    sansSerif = [theme.sansSerif.name];
    monospace = [theme.monospace.name];
    emoji = [theme.emoji.name];
  };
  environment.etc."xdg/gtk-2.0/gtkrc".text = ''
    gtk-theme-name = "Tokyonight-Dark"
  '';

  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name = Tokyonight-Dark
  '';
  xdg.icons.fallbackCursorThemes = [theme.cursor.name];
  packages = with pkgs; [
    theme.cursor.package
    themechanger
    tokyonight-gtk-theme
    # ayu-theme-gtk
    # (let
    #   rendersvg = runCommand "rendersvg" {} ''
    #     mkdir -p $out/bin
    #     ln -s ${pkgs.resvg}/bin/resvg $out/bin/rendersvg
    #   '';
    #   scheme.slug = "MateriaBase16";
    # in
    #   stdenv.mkDerivation {
    #     name = "generated-gtk-theme-${scheme.slug}";
    #     src = fetchFromGitHub {
    #       owner = "nana-4";
    #       repo = "materia-theme";
    #       rev = "76cac96ca7fe45dc9e5b9822b0fbb5f4cad47984";
    #       sha256 = "sha256-0eCAfm/MWXv6BbCl2vbVbvgv8DiUH09TAUhoKq7Ow0k=";
    #     };
    #     buildInputs = with pkgs; [
    #       sassc
    #       bc
    #       which
    #       rendersvg
    #       meson
    #       ninja
    #       nodePackages.sass
    #       gtk4.dev
    #       optipng
    #     ];
    #     phases = ["unpackPhase" "installPhase"];
    #     installPhase = ''
    #       HOME=/build
    #       chmod 777 -R .
    #       patchShebangs .
    #       mkdir -p $out/share/themes
    #       mkdir bin
    #       sed -e 's/handle-horz-.*//' -e 's/handle-vert-.*//' -i ./src/gtk-2.0/assets.txt

    #       cat > /build/gtk-colors << EOF
    #         BTN_BG=${theme.base02}
    #         BTN_FG=${theme.base06}
    #         FG=${theme.base05}
    #         BG=${theme.base00}
    #         HDR_BTN_BG=${theme.base01}
    #         HDR_BTN_FG=${theme.base05}
    #         ACCENT_BG=${theme.base0B}
    #         ACCENT_FG=${theme.base00}
    #         HDR_FG=${theme.base05}
    #         HDR_BG=${theme.base02}
    #         MATERIA_SURFACE=${theme.base02}
    #         MATERIA_VIEW=${theme.base01}
    #         MENU_BG=${theme.base02}
    #         MENU_FG=${theme.base06}
    #         SEL_BG=${theme.base0D}
    #         SEL_FG=${theme.base0E}
    #         TXT_BG=${theme.base02}
    #         TXT_FG=${theme.base06}
    #         WM_BORDER_FOCUS=${theme.base05}
    #         WM_BORDER_UNFOCUS=${theme.base03}
    #         UNITY_DEFAULT_LAUNCHER_STYLE=False
    #         NAME=${scheme.slug}
    #         MATERIA_STYLE_COMPACT=True
    #       EOF

    #       echo "Changing colours:"
    #       ./change_color.sh -o ${scheme.slug} /build/gtk-colors -i False -t "$out/share/themes"
    #       chmod 555 -R .
    #     '';
    #   })
  ];
}
