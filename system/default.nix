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
    ./wm
    ./aagl.nix
    ./nvidia.nix
    ./grub
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

    users.users = builtins.listToAttrs [
      {
        name = config.mainUser;
        value = {
          isNormalUser = true;
          description = config.mainUser;
          extraGroups = ["networkmanager" "wheel"];
          packages = [];
        };
      }
    ];

    networking.networkmanager.enable = true;

    nix = {
      settings.experimental-features = ["nix-command" "flakes"];
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
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
        enable = true;
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
