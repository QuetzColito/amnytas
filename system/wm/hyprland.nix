{pkgs, lib, config, ...}:
{
    config = lib.mkIf (config.wm == "Hyprland") {
        environment.systemPackages = with pkgs; [
            libnotify
        ];

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

        services.greetd = {
            enable = true;
            settings = rec {
                initial_session = {
                    command = "Hyprland";
                    user = config.mainUser;
                };
                default_session = initial_session;
            };
        };
    };
}
