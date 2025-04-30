{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hyprutils
    ./rules.nix
    ./binds.nix
    ./conf.nix
    ./monitors.nix
    ./autostart.nix
  ];

  config = {
    environment.systemPackages = with pkgs; [
      libnotify
    ];

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    services.getty.autologinUser = config.mainUser;
    services.getty.autologinOnce = true;

    environment.loginShellInit = ''
      if uwsm check may-start; then
          exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
}
