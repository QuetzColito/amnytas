{pkgs, ...}: {
  wantGrub = true;
  enableBluetooth = true;

  system.stateVersion = "25.11"; # Did you read the comment?
  virtualisation.waydroid.enable = true;

  hyprplugins = with pkgs.hyprlandPlugins; [
    hyprgrass
  ];

  monitors = [
    {
      name = "DP-3";
      coords = "-1920x0";
      workspaces = [4 5 6];
    }
    {
      name = "eDP-1";
      coords = "0x0";
      workspaces = [1 2 3 7 8 9];
    }
  ];

  services.upower.enable = true;
}
