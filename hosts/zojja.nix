{lib, ...}: {
  wm = "Hyprland";
  isNvidia = true;

  hardware.nvidia.open = lib.mkForce false;

  system.stateVersion = "23.11"; # Did you read the comment?
  monitors = [
    {
      name = "HDMI-A-1";
      coords = "0x0";
      workspaces = [1 2 3 4 5 6 7 8 9];
    }
  ];
}
