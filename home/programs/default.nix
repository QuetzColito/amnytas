{
  pkgs,
  ...
}: {
    imports = [
        ./foot.nix
    ];

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
        userSettings = import ./vscode-settings.nix;
    };

    home.packages = with pkgs; [
        # General
        parsec-bin
        qpwgraph
        appimage-run
        obs-studio
        discord
        protonmail-desktop

        # Gaming
        gamescope
        path-of-building
        osu-lazer-bin
        prismlauncher
        heroic
        protontricks
        xivlauncher

        ncdu
        # Media
        loupe
        komikku
        audacity
        vlc
        # Documents
        thunderbird
        onlyoffice-bin
        obsidian
    ];
}
