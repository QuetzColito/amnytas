{
  pkgs,
  config,
  inputs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./foot.nix
    ./ytm.nix
    ./gaming.nix
  ];

  users.users.${config.mainUser}.packages = with pkgs; [
    # Browser
    inputs.zen-browser.packages.${system}.specific
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
    spotify

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
    appimage-run
  ];
}
