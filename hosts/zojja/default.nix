{lib, ...}: {
  wm = "Hyprland";
  isNvidia = true;

  hardware.nvidia.open = lib.mkForce false;

  system.stateVersion = "23.11"; # Did you read the comment?
}
