{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./generated.nix
  ];

  config = lib.mkIf (config.wm == "Hyprland") {
    links = [
      ["amnytas/config/rice/hypr/hyprland.conf" ".config/hypr/hyprland.conf"]
      ["amnytas/config/rice/hypr/autostart.conf" ".config/hypr/autostart.conf"]
      ["amnytas/config/rice/hypr/binds.conf" ".config/hypr/binds.conf"]
      ["amnytas/config/rice/hypr/hypridle.conf" ".config/hypr/hypridle.conf"]
      ["amnytas/config/rice/hypr/rules.conf" ".config/hypr/rules.conf"]
      ["amnytas/config/rice/hypr/xdph.conf" ".config/hypr/xdph.conf"]
    ];

    environment.systemPackages = with pkgs; [
      libnotify
      hyprpolkitagent
    ];

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    services = {
      getty.autologinUser = config.mainUser;
      getty.autologinOnce = true;
    };

    environment.loginShellInit = ''
      if uwsm check may-start; then
          exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
}
