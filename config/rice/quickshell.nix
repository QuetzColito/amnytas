{
  inputs,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = [
    inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.kdePackages.qt5compat
    (pkgs.writeShellScriptBin "qs-reload" "qs kill; qs")
    (pkgs.writeShellScriptBin "toggleDashboard" "qs ipc call $(hyprctl activeworkspace -j | jq .monitor) dashboard")
    (pkgs.writeShellScriptBin "togglecurrentbar" "qs ipc call $(hyprctl activeworkspace -j | jq .monitor) bar")
    (pkgs.writeShellScriptBin "setWall" ''qs ipc call "bg$(hyprctl activeworkspace -j | jq .monitor)" set $1'')
  ];
  environment.variables.QS_CONFIG_PATH = "/home/${config.mainUser}/amnytas/config/rice/quickshell";
}
