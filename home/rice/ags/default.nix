{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  # add the home manager module
  imports = [inputs.ags.homeManagerModules.default];

  options = {
    agsCommand = lib.mkOption {
      default = "ags -c ~/amnytas/home/rice/ags/config.js";
      type = lib.types.str;
    };
  };
  config = {
    home.shellAliases.AGS = config.agsCommand;
    home.packages = [
      pkgs.sassc
      (pkgs.writeShellScriptBin "reloadags" "${config.agsCommand} -q; ${config.agsCommand}")
      (
        pkgs.writeShellScriptBin
        "togglecurrentbar"
        ''
          ags toggle bar-$(hyprctl activeworkspace -j | jq '.monitorID')
        ''
      )
    ];

    programs.ags = {
      enable = true;

      # additional packages to add to gjs's runtime
      extraPackages = with inputs.ags.packages.${pkgs.system}; [
        battery
        mpris
        hyprland
        wireplumber
        apps
        tray
      ];
    };
  };
}
