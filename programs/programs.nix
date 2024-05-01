{
  pkgs, 
  ...
}: {
  imports = [
    ./alacritty.nix
    ./zsh.nix
    ./rice/rice.nix
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  services.dunst = {
    enable = true;
    configFile = ./dunstrc;
    iconTheme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyo-night-gtk;
      size = "32x32";
    };
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
    parsec-bin
    qpwgraph
    neofetch
    appimage-run
    nix-index
    obs-studio
    docker

    # Discord xD
    webcord-vencord
    vesktop
    (discord.override {
      withVencord = true;
    })
    
    # Gaming
    osu-lazer-bin
    prismlauncher
    ferium
    heroic
    protontricks
    gamescope
    (pkgs.lutris.override {
      extraLibraries =  pkgs: [
      ];
    })

    # Utils
    xfce.thunar
    zathura
    unzip
    lazygit


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
    pngquant
    cliphist
    playerctl
    pamixer
    pavucontrol
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
