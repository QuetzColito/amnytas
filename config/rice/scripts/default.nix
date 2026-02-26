{pkgs, ...}: {
  packages = with pkgs; [
    (writeShellScriptBin "getActiveAudioStream" "${lib.getExe pkgs.go} run ${./getActiveAudioStream.go}")
  ];
}
