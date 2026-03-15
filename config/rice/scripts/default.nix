{pkgs, ...}: {
  packages = with pkgs; [
    (writeShellScriptBin "getActiveAudioStream" "${lib.getExe pkgs.go} run ${./getActiveAudioStream.go}")
    (writeShellScriptBin "find-exe" "sh ${./find-exe.sh}")
    (writeShellScriptBin "foot-find-exe" ''RUN="sh ${./find-exe.sh}" foot zsh'')
  ];
}
