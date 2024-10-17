{ pkgs, lib, config, ... }:
{
    config = lib.mkIf (config.wm == "Xfce") {
        # if you use pulseaudio
        nixpkgs.config.pulseaudio = true;

        services.xserver = {
            enable = true;
            desktopManager = {
                xterm.enable = false;
                xfce.enable = true;
            };
            displayManager.defaultSession = "xfce";
        };

        xdg.portal = {
            enable = true;
            extraPortals = [
                pkgs.xdg-desktop-portal-gtk
            ];
        };
    };
}
