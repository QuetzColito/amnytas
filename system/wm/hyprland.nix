{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    waybar
    dunst
    libnotify
    hyprpaper
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "quetz";
      };
    default_session = initial_session;
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.dbus.enable = true;
  xdg.portal = {
      enable = true;
      config.common.default = "wlr";
      wlr.enable = true;
      extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
      #pkgs.xdg-desktop-portal-wlr
    ];
  };

}