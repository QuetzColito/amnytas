# --- Hyprland, my main. uses greetd with autologin and then Hyprland instantly spawns a lockscreen
# It restarts itself automatically once if i close Hyprland, after that it crashes, no idea why
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

    security.pam.services.hyprlock = {};

    services.getty.autologinUser = config.mainUser;
    programs.bash.loginShellInit = ''
      if uwsm check may-start -v; then
          exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
}
