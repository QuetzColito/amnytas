# --- KDE, for whenever something doesnt work in Hyprland (which actually is pretty rare)
{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.wm == "Kde") {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    nixpkgs.config.pulseaudio = true;

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      oxygen
    ];
  };
}
