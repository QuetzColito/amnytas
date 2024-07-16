{ pkgs, ... } :
{
  system.stateVersion = "24.05";
  wsl.enable = true;
  imports = [
    ../../stylix.nix
  ];
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
#   services.xserver.xkb = {
#     layout = "eu";
#     variant = "";
#   };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    home-manager
  ];

#   virtualisation.docker.rootless = {
#     enable = true;
#     setSocketVariable = true;
#   };

#   fonts.packages = with pkgs; [
#       material-icons
#       material-design-icons
#       roboto
#       noto-fonts-cjk
#       (nerdfonts.override {fonts = ["IosevkaTerm" "Iosevka" "JetBrainsMono"];})
#       fira-code-nerdfont
#   ];
}