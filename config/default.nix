{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    ./programs
    ./terminal
    ./hjem.nix
    ./general

    # Pick GUI
    ./rice # Hyprland
    ./DEs/kde.nix # Kde
    ./DEs/cosmic.nix # Cosmic
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

    firstInstall = lib.mkEnableOption "Enable if cachix isn't setup yet";

    wm = lib.mkOption {
      default = "Hyprland"; # Hyprland, KDE, or Cosmic
      type = lib.types.str;
    };
  };

  config = {
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
    networking.networkmanager.enable = true;
    programs.nm-applet.enable = true;

    users.users.${config.mainUser} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = config.mainUser;
      extraGroups = ["networkmanager" "wheel"];
      packages = [];
    };

    nixpkgs.config.allowUnfree = true;
    nix = {
      settings.experimental-features = ["nix-command" "flakes"];
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    };
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/${config.mainUser}/amnytas";
    };

    services = {
      # Sound
      pipewire = {
        enable = true;
        pulse.enable = true;
        # jack.enable = true;
        # alsa.enable = true;
        # wireplumber.enable = true;
      };

      # Flatpak, although i actually dont need it anymore rn
      # Disabled because it made me rebuild a broken xwayland version???????
      flatpak.enable = true;

      # Secrets Manager
      gnome.gnome-keyring.enable = true;
    };

    # Important for laptop, dunno about desktop
    powerManagement.enable = true;

    # only basic stuff
    environment.systemPackages = with pkgs; [
      vim
      wget
      git
    ];
  };
}
