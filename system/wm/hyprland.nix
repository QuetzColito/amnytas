# --- Hyprland, my main. uses greetd with autologin and then Hyprland instantly spawns a lockscreen
# It restarts itself automatically once if i close Hyprland, after that it crashes, no idea why
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
            # gotta investigate if i still need this now that hyprland has aquamarine
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
