{
  pkgs,
  # pkgs-stable,
  inputs,
  system,
  ...
}: {
  imports = [
    ./foot.nix
    ./appimages.nix
    ./imv.nix
    ./nixcord.nix
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs = {
    mpv.enable = true;
    spicetify.enable = true;

    vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
  };

  # for good measure, dunno if it does anything
  home.sessionVariables.BROWSER = "zen";

  home.packages = with pkgs; [
    # General
    inputs.zen-browser.packages."${system}".specific
    parsec-bin
    qpwgraph
    appimage-run
    obs-studio
    discord-canary
    jetbrains.idea-community
    # equibop
    protonmail-desktop
    brave

    # Gaming
    gamescope
    gamemode
    path-of-building
    osu-lazer-bin
    prismlauncher
    heroic
    legendary-gl
    xivlauncher
    vkbasalt

    ncdu
    # Media
    inkscape
    gcolor3
    gnome-disk-utility
    komikku
    audacity
    vlc
    pinta
    conjure
    # Documents
    zotero
    thunderbird
    onlyoffice-bin
    obsidian
    # autoscale imv to the image
    # (writeShellScriptBin "imvs"
    #   ''
    #     imv $1 -W 212 -H 333
    #   '')
    (writeShellScriptBin "imvs"
      ''
        imv $1 -W $(magick identify -format %w $1) -H$(magick identify -format %h $1)
      '')
    (writeShellScriptBin "mpa"
      ''
        foot --override=app-id=floatfoot --override=initial-window-size-chars=70x5 mpv --no-audio-display $@
      '')
    (writeShellScriptBin "t"
      ''
        convert "$1"_Card.webp ~/Pictures/cards/originals/"$1".png
        rm "$1"_Card.webp
      '')
    (let
      pname = "YouTube-Music";
      version = "3.7.1";

      src = inputs.ytm-src;
    in
      appimageTools.wrapType2 {
        inherit pname version src;
      })
  ];
}
