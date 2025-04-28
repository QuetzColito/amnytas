{
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./foot.nix
    ./ytm.nix
    ./discord.nix
    ./gaming.nix
    ./spotify.nix
  ];

  programs = {
    xfconf.enable = true; # Also for Thunar
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
        tumbler
      ];
    };
  };

  packages = with pkgs; [
    # Browser
    (import ./zen.nix pkgs)
    brave

    # Util
    gnome-disk-utility
    ncdu
    qpwgraph
    exiftool

    # Comms
    pkgs-stable.rustdesk-flutter
    discord-canary
    thunderbird
    vesktop

    # Audio
    audacity

    # Video
    mpv
    obs-studio
    vlc

    # Image
    imv
    inkscape
    conjure
    drawio
    komikku
    pinta

    # Documents
    zathura
    onlyoffice-bin
    obsidian

    # Other
    jetbrains.idea-community
    vscodium
    appimage-run
  ];
}
