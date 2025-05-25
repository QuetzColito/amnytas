# KDE, for whenever something doesnt work in Hyprland (which actually is pretty rare)
{
  config,
  lib,
  ...
}: {
  services = lib.mkIf (config.wm == "KDE") {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    # displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;
  };
  nixpkgs.config.pulseaudio = true;
}
