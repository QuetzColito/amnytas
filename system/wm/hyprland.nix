{pkgs, lib, ...}:
{
  environment.systemPackages = with pkgs; [
    libnotify
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  security.pam.services.hyprlock = {};

  services.dbus.enable = true;
  xdg.portal = {
      enable = true;
      config.common.default = "wlr";
      wlr.enable = lib.mkForce true;
      extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
      #pkgs.xdg-desktop-portal-wlr
    ];
  };
  #boot.kernelParams = [
  #  "initcall_blacklist=simpledrm_platform_driver_init"
  #];

}
