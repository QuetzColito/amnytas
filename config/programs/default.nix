{
  pkgs,
  config,
  inputs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./foot.nix
    ./aagl.nix
    ./ytm.nix
  ];
  users.users.${config.mainUser}.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".specific
    pkgs-stable.rustdesk-flutter
    qpwgraph
    appimage-run
    obs-studio
    discord-canary
    foot
    jetbrains.idea-community
    vesktop
    brave

    # Gaming
    gamescope
    gamemode
    path-of-building
    osu-lazer-bin
    prismlauncher
    heroic
    xivlauncher
    vkbasalt

    # Media
    inkscape
    gcolor3
    gnome-disk-utility
    ncdu
    komikku
    audacity
    vlc
    mpv
    imv
    zathura
    exiftool
    pinta
    conjure
    # Documents
    zotero
    thunderbird
    onlyoffice-bin
    obsidian
    drawio
    (writeShellScriptBin "imvs"
      ''
        imv $1 -W $(magick identify -format %w $1) -H$(magick identify -format %h $1)
      '')
    (writeShellScriptBin "mpa"
      ''
        foot --override=app-id=floatfoot --override=initial-window-size-chars=70x5 mpv --no-audio-display $@
      '')
    (let
      pname = "YouTube-Music";
      version = "3.7.5";

      src = inputs.ytm-src;
    in
      appimageTools.wrapType2 {
        inherit pname version src;
      })
  ];
}
