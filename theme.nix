pkgs: rec {
  base00 = "16161E"; # ----
  base01 = "1A1B26"; # ---
  base02 = "2F3549"; # --
  base03 = "444B6A"; # -
  base04 = "787C99"; # +
  base05 = "A9B1D6"; # ++
  base06 = "CBCCD1"; # +++
  base07 = "D5D6DB"; # ++++
  base08 = "F7768E"; # Red
  base09 = "FF9E64"; # Orange
  base0A = "E0AF68"; # Yellow
  base0B = "9ECE6A"; # Green
  base0C = "7DCFFF"; # Cyan
  base0D = "7AA2F7"; # Blue
  base0E = "BB9AF7"; # Purple
  base0F = "D18616"; # Brown

  serif = {
    package = pkgs.inter;
    name = "Inter";
  };

  sansSerif = {
    package = pkgs.inter;
    name = "Inter";
  };

  monospace = {
    package = pkgs.nerd-fonts.geist-mono;
    name = "GeistMono Nerd Font Mono";
  };

  emoji = {
    package = pkgs.noto-fonts-emoji;
    name = "Noto Color Emoji";
  };

  cursor = {
    size = "32";
    name = "Miku-Cursor";
    package = pkgs.stdenv.mkDerivation {
      pname = "miku-cursors";

      version = "1.2.6";

      src = pkgs.fetchFromGitHub {
        owner = "QuetzColito";
        repo = "hatsune-miku-cursors";
        rev = "e5b7cb1e46555204039803eb5bdf1c5ae6cdbf8e";
        sha256 = "SVGYAM4C8X1ptOD/MV3NcCaXs9FeIwjS4Bjcgcr9K4Q=";
      };

      buildInputs = [];

      installPhase = ''
        runHook preInstall
        install -dm 755 $out/share/icons
        cp -r Miku-Cursor $out/share/icons/Miku-Cursor
        runHook postInstall
      '';
    };
  };

  gtk = {
    name = "MateriaBase16";
    package = let
      rendersvg = pkgs.runCommand "rendersvg" {} ''
        mkdir -p $out/bin
        ln -s ${pkgs.resvg}/bin/resvg $out/bin/rendersvg
      '';
      theme-name = gtk.name;
    in
      pkgs.stdenv.mkDerivation rec {
        name = "generated-gtk-theme-${theme-name}";
        src = pkgs.fetchFromGitHub {
          owner = "nana-4";
          repo = "materia-theme";
          rev = "76cac96ca7fe45dc9e5b9822b0fbb5f4cad47984";
          sha256 = "sha256-0eCAfm/MWXv6BbCl2vbVbvgv8DiUH09TAUhoKq7Ow0k=";
        };
        buildInputs = with pkgs; [
          sassc
          bc
          which
          rendersvg
          meson
          ninja
          nodePackages.sass
          gtk4.dev
          optipng
        ];
        phases = ["unpackPhase" "installPhase"];
        installPhase = ''
          HOME=/build
          chmod 777 -R .
          patchShebangs .
          mkdir -p $out/share/themes
          mkdir bin
          sed -e 's/handle-horz-.*//' -e 's/handle-vert-.*//' -i ./src/gtk-2.0/assets.txt

          cat > /build/gtk-colors << EOF
            BTN_BG=${base02}
            BTN_FG=${base06}
            FG=${base05}
            BG=${base00}
            HDR_BTN_BG=${base01}
            HDR_BTN_FG=${base05}
            ACCENT_BG=${base0B}
            ACCENT_FG=${base00}
            HDR_FG=${base05}
            HDR_BG=${base02}
            MATERIA_SURFACE=${base02}
            MATERIA_VIEW=${base01}
            MENU_BG=${base02}
            MENU_FG=${base06}
            SEL_BG=${base0D}
            SEL_FG=${base0E}
            TXT_BG=${base02}
            TXT_FG=${base06}
            WM_BORDER_FOCUS=${base05}
            WM_BORDER_UNFOCUS=${base03}
            UNITY_DEFAULT_LAUNCHER_STYLE=False
            NAME=${theme-name}
            MATERIA_STYLE_COMPACT=True
          EOF

          echo "Changing colours:"
          ./change_color.sh -o ${theme-name} /build/gtk-colors -i False -t "$out/share/themes"
          chmod 555 -R .
        '';
      };
  };

  fcitx5 = {
    name = "Tokyonight-Storm";
    package = pkgs.stdenv.mkDerivation {
      pname = "fcitx5-Tokyonight";
      version = "v1";

      src = pkgs.fetchFromGitHub {
        owner = "ch4xer";
        repo = "fcitx5-Tokyonight";
        rev = "d3dcd387a3c995d996187a042b2ff23caa0dc9ae";
        sha256 = "aLrPNd1vnt8rMzjXaoUSXsW7lQdNEqadyMsFSQX1xeo=";
      };

      phases = ["unpackPhase" "installPhase"];

      installPhase = ''
        runHook preInstall
        install -dm 755 $out/share/fcitx5/themes
        cp -r Tokyonight-Storm $out/share/fcitx5/themes/Tokyonight-Storm
        runHook postInstall
      '';
    };
  };

  icons = {
    name = "TokyoNight-SE";
    package = pkgs.stdenv.mkDerivation {
      pname = "tokyonight-icons";
      version = "v0.2.0";

      src = pkgs.fetchurl {
        url = "https://github.com/ljmill/tokyo-night-icons/releases/download/v0.2.0/TokyoNight-SE.tar.bz2";
        sha256 = "s6aqdswMj8Vk7dlTD6gZAq3OlM1PrDodjvhAqsYRlqo=";
      };

      phases = ["unpackPhase" "installPhase"];

      installPhase = ''
        runHook preInstall
        install -dm 755 $out/share/icons
        cp -r . $out/share/icons/TokyoNight-SE
        runHook postInstall
      '';
    };
  };

  colours = {inherit base00 base01 base02 base03 base04 base05 base06 base07 base08 base09 base0A base0B base0C base0D base0E base0F;};
  fonts = [serif.package sansSerif.package monospace.package emoji.package];
}
