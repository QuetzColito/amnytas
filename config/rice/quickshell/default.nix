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
  ];
  environment.variables.QS_CONFIG_PATH = "/home/${config.mainUser}/amnytas/config/rice/quickshell/config";
}
