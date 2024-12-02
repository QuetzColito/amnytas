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
      extraModulePackages = with config.boot.kernelPackages; [v4l2loopback.out];
    };

    networking.hostName = config.hostName;

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

    programs.nm-applet.enable = true;
    networking.networkmanager.enable = true;

    nix = {
      settings.experimental-features = ["nix-command" "flakes"];
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    };

    # Locale
    time.timeZone = "Europe/Berlin";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
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

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "eu";
      variant = "";
      options = "caps:escape,lv3:switch";
    };

    # Fcitx5
    services.xserver.desktopManager.runXdgAutostartIfNone = true;

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-nord
          fcitx5-gtk
        ];
      };
    };

    # Important for laptop, dunno about desktop
    powerManagement.enable = true;

    nixpkgs.config.allowUnfree = true;

    # needed for AGS Mpris
    services.gvfs.enable = true;

    # only basic stuff
    environment.systemPackages = with pkgs; [
      vim
      wget
      git
      firefox
      home-manager
      qemu
      quickemu
      wineWowPackages.waylandFull # dunno why i have this
    ];

    # Docker
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    # Sound
    # sound.mediaKeys.enable = true;
    programs.noisetorch.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
    };

    # Flatpak, although i actually dont need it anymore rn
    services.flatpak.enable = true;

    # Steam
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    # Thunar stuff, only using thunar when i need drag and drop xD
    programs.dconf.enable = true; # gnome-related
    programs.xfconf.enable = true;
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
        tumbler
      ];
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
  };
}
