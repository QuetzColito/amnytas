{pkgs, ...}: {
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

    firefox = {
      enable = true;
      nativeMessagingHosts.packages = [pkgs.tridactyl-native];
    };
  };

  packages = with pkgs; [
    # Browser
    brave

    # Util
    gnome-disk-utility
    ncdu
    qpwgraph
    exiftool

    # Comms
    # pkgs-stable.rustdesk-flutter
    rustdesk-flutter
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
    libreoffice
    obsidian

    # Other
    # jetbrains.idea-community
    vscodium
    appimage-run
  ];
}
