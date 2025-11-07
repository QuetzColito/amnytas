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
    package = pkgs.noto-fonts-color-emoji;
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
    # Colloid Catppuccin overwritten with base16
    name = "Colloid-Purple-Dark-Catppuccin";
    package = (pkgs.colloid-gtk-theme.overrideAttrs
      (finalAttrs: previousAttrs: {
        # tried to refactor this to make it less chonky and just failed xD
        postPatch = ''
          ${previousAttrs.postPatch}
          rm src/sass/_color-palette-catppuccin.scss
          echo "\$red-light: #${base08};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$red-dark: #${base08};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$pink-light: #${base0F};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$pink-dark: #${base0F};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$purple-light: #${base0E};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$purple-dark: #${base0E};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$blue-light: #${base0D};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$blue-dark: #${base0D};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$teal-light: #${base0C};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$teal-dark: #${base0C};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$green-light: #${base0B};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$green-dark: #${base0B};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$yellow-light: #${base0A};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$yellow-dark: #${base0A};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$orange-light: #${base09};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$orange-dark: #${base09};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-050: #${base07};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-100: #${base07};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-150: #${base06};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-200: #${base06};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-250: #${base05};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-300: #${base05};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-350: #${base04};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-400: #${base04};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-450: #${base03};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-500: #${base03};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-550: #${base02};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-600: #${base02};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-650: #${base02};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-700: #${base01};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-750: #${base01};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-800: #${base01};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-850: #${base00};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-900: #${base00};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$grey-950: #${base00};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$white: #${base07};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$black: #${base00};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$button-close: #${base08};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$button-max: #${base0B};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$button-min: #${base09};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$links: #${base0D};" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$default-light: \$blue-light;" >> "src/sass/_color-palette-catppuccin.scss"
          echo "\$default-dark: \$blue-dark;" >> "src/sass/_color-palette-catppuccin.scss"
        '';
      })).override {
      colorVariants = ["dark"];
      themeVariants = ["purple"];
      tweaks = ["catppuccin" "rimless"];
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
