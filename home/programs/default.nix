{
  lib,
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
  ];

  programs.mpv.enable = true;

  # VScodium, although i dont use it anymore
  stylix.targets.vscode.enable = false;
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      redhat.java
      haskell.haskell
      vscodevim.vim
      pkief.material-icon-theme
      justusadam.language-haskell
      jnoortheen.nix-ide
      johnpapa.vscode-peacock
      enkia.tokyo-night
    ];
    # userSettings = import ./vscode-settings.nix;
  };

  # for good measure, dunno if it does anything
  home.sessionVariables.BROWSER = "zen";

  home.packages =
    [
      inputs.zen-browser.packages."${system}".specific
    ]
    ++ (with pkgs; [
      # General
      parsec-bin
      qpwgraph
      appimage-run
      obs-studio
      discord-canary
      vesktop
      jetbrains.idea-community
      # equibop
      protonmail-desktop
      brave
      inputs.ghostty.packages.x86_64-linux.default

      # Gaming
      gamescope
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
      spotify
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
        version = "3.6.2";

        src = inputs.ytm-src;
      in
        appimageTools.wrapType2 {
          inherit pname version src;
        })
    ]);
}
