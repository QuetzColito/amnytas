{
  pkgs,
  theme,
  ...
}: {
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
    # Fcitx5, Disabled cause it fucked up my inputs
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

  files.".config/fcitx5/".source = ./fcitx5;

  files.".local/share/fcitx5/themes".source = pkgs.fetchFromGitHub {
    owner = "ch4xer";
    repo = "fcitx5-Tokyonight";
    rev = "d3dcd387a3c995d996187a042b2ff23caa0dc9ae";
    sha256 = "aLrPNd1vnt8rMzjXaoUSXsW7lQdNEqadyMsFSQX1xeo=";
  };

  # Configure keymap in X11 (Other settings may reference this as SPOT)
  services.xserver = {
    exportConfiguration = true;
    xkb = {
      layout = "eu";
      variant = "";
      options = "caps:escape,lv3:switch";
    };
  };
}
