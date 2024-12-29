{pkgs, ...}: {
  # i dont think this is how you are supposed to do it, but never bothered to look into it
  home.packages = with pkgs; [
    # (writeShellScriptBin "youtubemusic"
    #   "for i in ~/apps/ytm/*.AppImage ; do appimage-run $i; done")
    (writeShellScriptBin "geforcenow"
      "for i in ~/apps/GFN/*.AppImage ; do appimage-run $i; done")
    (writeShellScriptBin "krita"
      "for i in ~/apps/krita/*.appimage ; do appimage-run $i; done")
    (writeShellScriptBin "poetrade"
      "for i in ~/apps/poetrade/*.AppImage ; do appimage-run $i --no-overlay; done")
  ];
}
