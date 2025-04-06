pkgs: rec {
  base00 = "16161E"; # Default Background
  base01 = "1A1B26"; # Lighter Background
  base02 = "2F3549"; # Selection Background
  base03 = "444B6A"; # Comments - Invisibles
  base04 = "787C99"; # Dark Foreground
  base05 = "A9B1D6"; # Default Foreground
  base06 = "CBCCD1"; # Light Foreground
  base07 = "D5D6DB"; # Light Background
  base08 = "F7768E"; # Red # Variables, XML Tags, Markup Link/Lists
  base09 = "FF9E64"; # Orange # Ints, Bools, Consts, XML Attrs, Markup link url
  base0A = "E0AF68"; # Yellow # Classes, Markup bold, Search Text Background
  base0B = "9ECE6A"; # Green # Strings, Inherited Class, Markup Code, Diff Inserted
  base0C = "7DCFFF"; # Cyan # Support, Regular Expressions, Escape Characters, Markup Quotes
  base0D = "7AA2F7"; # Blue # Functions, Methods, Attribute IDs, Headings
  base0E = "BB9AF7"; # Purple # Keywords, Storage, Selector, Markup Italic, Diff Changed
  base0F = "D18616"; # Dark Orange # Deprecated, Opening/Closing Embedded Language Tags

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
    size = "24";
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
    name = "palenight";
    package = pkgs.palenight-theme;
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

  qt = {
    name = "";
    package = {};
  };

  colours = {inherit base00 base01 base02 base03 base04 base05 base06 base07 base08 base09 base0A base0B base0C base0D base0E base0F;};
  fonts = [serif.package sansSerif.package monospace.package emoji.package];
}
