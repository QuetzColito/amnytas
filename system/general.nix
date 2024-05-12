{pkgs, lib, config, ...}:
let
  aagl-gtk-on-nix = import (builtins.fetchTarball {
    url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
    sha256 = sha256:1vfmfw31v2inv792vxgi96k963zwj7hl3lxs45dg2sf46nh4bcrp;
    });
in
{
  # Enable networking

  boot.kernelModules = ["v4l2loopback"];

  boot.extraModulePackages = with config.boot.kernelPackages;
    [ v4l2loopback.out ];

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
  };

  powerManagement.enable = true;
  # Allow unfree and external packages
  nixpkgs.config.allowUnfree = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Missing libraries go here
    ];
  };

  environment.systemPackages = [
    pkgs.vim
    pkgs.wget
    pkgs.git
    pkgs.firefox
    pkgs.home-manager
    pkgs.qemu
    pkgs.quickemu
    pkgs.wineWowPackages.waylandFull
    pkgs-stable.haskellPackages.hls
    pkgs-stable.haskellPackages.ghcup
  ];

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # sound.mediaKeys.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.flatpak.enable = true;


  nix.settings = {
    substituters = [ "https://ezkea.cachix.org" ];
    trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };

  imports = [
    aagl-gtk-on-nix.module
  ];

  programs.honkers-railway-launcher.enable = true;

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
      tumbler
    ];
  };

  fonts.packages = with pkgs; [
      material-icons
      material-design-icons
      roboto
      work-sans
      comic-neue
      source-sans
      twemoji-color-font
      comfortaa
      inter
      lato
      lexend
      jost
      dejavu_fonts
      iosevka-bin
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      jetbrains-mono
      (nerdfonts.override {fonts = ["Iosevka" "JetBrainsMono"];})
      fira-code-nerdfont
  ];

}
