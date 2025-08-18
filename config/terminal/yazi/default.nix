{pkgs, ...}: {
  packages = with pkgs; [
    foot
    imv
    mpv
    zathura
    ouch
    (writeShellScriptBin "imvs"
      ''
        imv $1 -W $(magick identify -format %w $1) -H$(magick identify -format %h $1)
      '')
    (writeShellScriptBin "mpa"
      ''
        foot --override=app-id=floatfoot --override=initial-window-size-chars=70x5 mpv --no-audio-display "$1"
      '')
  ];

  links = [
    ["amnytas/config/terminal/yazi/keymap.toml" ".config/yazi/keymap.toml"]
    ["amnytas/config/terminal/yazi/yazi.toml" ".config/yazi/yazi.toml"]
    ["amnytas/config/terminal/yazi/theme.toml" ".config/yazi/theme.toml"]
  ];

  files.".config/yazi/plugins/ouch.yazi".source = pkgs.fetchFromGitHub {
    owner = "ndtoan96";
    repo = "ouch.yazi";
    tag = "v0.6.0";
    sha256 = "sha256-mtXl76a54Deg4cyrD0wr++sD/5b/kCsnJ+ngM6OokTc=";
  };
}
