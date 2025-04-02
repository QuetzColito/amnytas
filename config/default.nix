{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    ../stylix.nix
    inputs.stylix.nixosModules.stylix
    ./DEs
    ./nvidia.nix
  ];

  options = {
    mainUser = lib.mkOption {
      default = "nixos";
      type = lib.types.str;
    };
    hostName = lib.mkOption {
      default = "nixos";
      type = lib.types.str;
    };
    wm = lib.mkOption {
      default = "Hyprland"; # Hyprland, Cosmic, Xfce, Kde or none
      type = lib.types.str;
    };
    firstInstall = lib.mkEnableOption "Enable if cachix isn't setup yet";
  };

  # A lot of stuff in here was generated at the start and i didnt touch it

  config = {
    # programs.nix-ld = {
    #   enable = true;
    #   libraries = with pkgs; [ ];
    # };
    # environment.sessionVariables = {
    #   DOTNET_ROOT = "${pkgs.dotnet-sdk}";
    # };
    boot = {
      loader = {
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = 2;
        efi.canTouchEfiVariables = true;
      };
      tmp.cleanOnBoot = true;
      kernelModules = ["v4l2loopback"];
      supportedFilesystems = ["ntfs"];
      extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
      extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';
    };

    security.polkit.enable = true;

    networking.hostName = config.hostName;
    programs.nm-applet.enable = true;

    users.users.${config.mainUser} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = config.mainUser;
      extraGroups = ["networkmanager" "wheel"];
      packages = [
        (pkgs.stdenv.mkDerivation {
          pname = "miku-cursors";

          version = "1.2.6";

          src = pkgs.fetchFromGitHub {
            owner = "QuetzColito";
            repo = "hatsune-miku-cursors";
            rev = "e5b7cb1e46555204039803eb5bdf1c5ae6cdbf8e";
            sha256 = "SVGYAM4C8X1ptOD/MV3NcCaXs9FeIwjS4Bjcgcr9K4Q=";
          };

          buildInputs = [];

          installPhase = ''
            runHook preInstall
            install -dm 755 $out/share/icons
            cp -r Miku-Cursor $out/share/icons/Miku-Cursor
            runHook postInstall
          '';
        })
      ];
    };

    networking.networkmanager.enable = true;

    xdg.icons.fallbackCursorThemes = ["Miku-Cursor"];

    nix = {
      settings.experimental-features = ["nix-command" "flakes"];
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
      };
    };

    # Locale
    time.timeZone = "Europe/Berlin";

    i18n = {
      defaultLocale = "en_US.UTF-8";

      extraLocaleSettings = {
        LC_ADDRESS = "de_DE.UTF-8";
        LC_IDENTIFICATION = "de_DE.UTF-8";
        LC_MEASUREMENT = "de_DE.UTF-8";
        LC_MONETARY = "de_DE.UTF-8";
        LC_NAME = "de_DE.UTF-8";
        LC_NUMERIC = "de_DE.UTF-8";
        LC_PAPER = "de_DE.UTF-8";
        LC_TELEPHONE = "de_DE.UTF-8";
        LC_TIME = "de_DE.UTF-8";
      };
      # Fcitx5
      inputMethod = {
        enable = false;
        type = "fcitx5";
        fcitx5 = {
          waylandFrontend = true;
          addons = with pkgs; [
            fcitx5-mozc
          ];
        };
      };
    };

    # fonts, dont remove the cjk one or kana will look ugly
    fonts.packages = with pkgs; [
      inter
      material-icons
      material-design-icons
      roboto
      noto-fonts-cjk-sans
      nerd-fonts.geist-mono
    ];

    services = {
      # Configure keymap in X11
      xserver = {
        exportConfiguration = true;
        xkb = {
          layout = "eu";
          variant = "";
          options = "caps:escape,lv3:switch";
        };
      };
      # needed for AGS Mpris
      gvfs.enable = true;

      # Sound
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
        jack.enable = true;
      };
      # Flatpak, although i actually dont need it anymore rn
      flatpak.enable = true;

      # Secrets Manager
      gnome.gnome-keyring.enable = true;
    };

    # Important for laptop, dunno about desktop
    powerManagement.enable = true;

    nixpkgs.config.allowUnfree = true;

    # only basic stuff
    environment.systemPackages = with pkgs; [
      vim
      wget
      git
      kitty
      firefox
      home-manager
      qemu
      quickemu
    ];

    # Docker
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    programs = {
      # Steam
      steam = {
        enable = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        extraCompatPackages = [pkgs.proton-ge-bin];
      };

      # Thunar
      dconf.enable = true; # gnome-related
      xfconf.enable = true;
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
  };
}
