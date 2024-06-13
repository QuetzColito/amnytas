{
  pkgs, 
  ...
}: {
  imports = [
    ./alacritty.nix
    ./zsh.nix
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
    userSettings = import ./settings.nix;
  };


  programs.git = {
    enable = true;
    userEmail = "stefan.lahne@gmx.de";
    userName = "Stefan Lahne";
  };

  home.packages = with pkgs; [

    # General
    starship
    nil
    btop
    cmatrix
    sl
    parsec-bin
    qpwgraph
    fastfetch
    appimage-run
    nix-index
    obs-studio
    discord
    pandoc
    texliveSmall
    
    # Gaming
    osu-lazer-bin
    prismlauncher
    heroic
    protontricks

    # Utils
    zip
    unzip
    lazygit
    usbutils
    poppler_utils
    # Files
    baobab
    gnome.gnome-disk-utility
    gnome.file-roller
    fzf
    fd
    ncdu
    # Media
    gnome.totem
    loupe
    komikku
    imagemagick
    audacity
    vlc
    # Documents
    zathura
    thunderbird
    onlyoffice-bin
    obsidian


    # Hyprland
    wf-recorder
    brightnessctl
    slurp
    grim
    hyprpicker
    grimblast
    bibata-cursors
    wl-clip-persist
    wl-clipboard
    xclip
    pngquant
    cliphist
    playerctl
    pamixer
    pavucontrol
    socat
    (writeShellScriptBin
      "handle_monitor_connect"
      ''
        handle() {
          case $1 in monitoradded*)
            hyprctl dispatch moveworkspacetomonitor "1 1"
            hyprctl dispatch moveworkspacetomonitor "2 1"
            hyprctl dispatch moveworkspacetomonitor "4 1"
            hyprctl dispatch moveworkspacetomonitor "5 1"
          esac
        }

        socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/\$\{HYPRLAND_INSTANCE_SIGNATURE\}/.socket2.sock" | while read -r line; do handle "$line"; done
      '')
    (writeShellScriptBin
      "pauseshot"
      ''
        ${hyprpicker}/bin/hyprpicker -r -z &
        picker_proc=$!

        ${grimblast}/bin/grimblast save area - | tee ~/pics/ss$(date +'screenshot-%F') | wl-copy

        kill $picker_proc
      '')
    (writeShellScriptBin
      "pauseshotarea"
      ''
        ${hyprpicker}/bin/hyprpicker -r -z &
        picker_proc=$!

        grim -g \"$(slurp)\" - | wl-copy

        kill $picker_proc
      '')
  ];


}
