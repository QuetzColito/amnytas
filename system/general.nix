{pkgs, lib, config, ...}:
{
  imports = [
    ../stylix.nix
  ];
  boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;

      tmp.cleanOnBoot = true;

      kernelModules = ["v4l2loopback"];
      supportedFilesystems = [ "ntfs" ];

      extraModulePackages = with config.boot.kernelPackages;
        [ v4l2loopback.out ];

    };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
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

  powerManagement.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      xorg.libXcursor
      xorg.libXinerama
      xorg.libXext
      xorg.libXrandr
      xorg.libXrender
      xorg.libX11
      xorg.libXi
      libGL
      # Add any missing dynamic libraries for unpackaged programs here,
      # NOT in environment.systemPackages
    ];
  };
  # improves compatability
  # services.envfs.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    firefox
    home-manager
    qemu
    quickemu
    wineWowPackages.waylandFull
  ];

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # sound.mediaKeys.enable = true;
  programs.noisetorch.enable=true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.flatpak.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

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

  fonts.packages = with pkgs; [
      inter
      dejavu_fonts
      material-icons
      material-design-icons
      roboto
      noto-fonts-cjk
      (nerdfonts.override {fonts = ["IosevkaTerm" "Iosevka" "JetBrainsMono"];})
      fira-code-nerdfont
  ];



}
