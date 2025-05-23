{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    agsCommand = lib.mkOption {
      default = "ags run ~/amnytas/config/rice/ags";
      type = lib.types.str;
    };
  };

  config = {
    services.gvfs.enable = true;
    packages = with pkgs; [
      pkgs.sassc
      (pkgs.writeShellScriptBin "ags-reload" "ags quit; ${config.agsCommand}")
      (
        pkgs.writeShellScriptBin
        "togglecurrentbar"
        ''
          ags toggle bar-$(hyprctl activeworkspace -j | jq '.monitorID')
        ''
      )
      (inputs.ags.packages.${system}.default.override {
        extraPackages = with inputs.ags.packages.${system}; [
          battery
          mpris
          hyprland
          wireplumber
          apps
          tray
        ];
      })
    ];
  };
}
