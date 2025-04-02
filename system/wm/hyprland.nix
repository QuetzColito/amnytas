{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.wm == "Hyprland") {
    environment.systemPackages = with pkgs; [
      libnotify
    ];

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };

    # dont remove
    security.pam.services.hyprlock = {};

    services.getty.autologinUser = config.mainUser;

    environment.loginShellInit = ''
      if uwsm check may-start -v; then
          exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
}
