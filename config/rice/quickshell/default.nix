{
  inputs,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = [
    inputs.quickshell.packages.${pkgs.system}.default
    pkgs.kdePackages.qt5compat
    (pkgs.writeShellScriptBin "qs-reload" "qs kill; qs")
    (pkgs.writeShellScriptBin "toggleDashboard" "qs ipc call $(hyprctl activeworkspace -j | jq .monitor) dashboard")
    (pkgs.writeShellScriptBin "togglecurrentbar" "qs ipc call $(hyprctl activeworkspace -j | jq .monitor) bar")
  ];
  environment.variables.QS_CONFIG_PATH = "/home/${config.mainUser}/amnytas/config/rice/quickshell/config";
}
