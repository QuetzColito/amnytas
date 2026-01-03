{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./generated.nix
    inputs.hyprland.nixosModules.default
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

    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    programs.hyprland = {
      enable = true;
      # set the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

      plugins = with inputs.hyprland-plugins.${pkgs.stdenv.hostPlatform.system}; [
      ];
    };

    services = {
      getty.autologinUser = config.mainUser;
      getty.autologinOnce = true;
    };

    packages = [
      pkgs.uwsm
    ];

    environment.loginShellInit = ''
      if uwsm check may-start; then
          start-hyprland
      fi
    '';
  };
}
