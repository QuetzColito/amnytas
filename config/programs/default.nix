{
  pkgs,
  inputs,
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
      plugins = with pkgs; [
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

  programs.noisetorch.enable = true;

  packages = with pkgs;
    [
      # Browser
      google-chrome
      (writeShellScriptBin "helium" "appimage-run ${inputs.helium}")

      # Util
      gnome-disk-utility
      ncdu
      qpwgraph

      # Comms
      thunderbird

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
      protonvpn-gui
    ]
    # Some Webapps
    ++ (let
      webapp = name: url: (pkgs.writeShellScriptBin name ''uwsm app -- google-chrome-stable --new-window --ozone-platform=wayland --app="https://${url}"'');
    in [
      (webapp "crunchyroll" "crunchyroll.com")
      (webapp "netflix" "netflix.com")
      (webapp "mailproton" "mail.proton.me")
      (webapp "passproton" "pass.proton.me")
      (webapp "wanikani" "wanikani.com")
    ]);
}
