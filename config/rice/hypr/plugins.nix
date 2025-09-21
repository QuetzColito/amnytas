{
  pkgs,
  hh,
  config,
  lib,
  ...
}: {
  options = {
    hyprplugins = lib.mkOption {
      default = [];
      type = lib.types.listOf lib.types.package;
    };
  };

  config = let
    mkPluginScript = command: builtins.concatStringsSep "\n" (map (p: "hyprctl plugin ${command} ${p}/lib/lib${p.pname}.so") config.hyprplugins);
  in {
    hyprplugins = with pkgs.hyprlandPlugins; [
    ];

    files.".config/hypr/plugins.conf".text = hh.mkList "exec-once" (map (p: "hyprctl plugin load ${p}/lib/lib${p.pname}.so") config.hyprplugins);

    packages = with pkgs; [
      (writeShellScriptBin "loadHyprPlugins" (mkPluginScript "load"))
      (writeShellScriptBin "unloadHyprPlugins" (mkPluginScript "unload"))
    ];
  };
}
