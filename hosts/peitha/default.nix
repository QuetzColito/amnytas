_: {
  wm = "Hyprland";
  isNvidia = false;
  wantGrub = true;

  system.stateVersion = "24.05"; # Did you read the comment?

  fileSystems."/home/quetz/storage" = {
    device = "/dev/sda4";
    options = ["nofail"];
  };

  autostartApps = true;

  monitors = [
    {
      name = "DP-1";
      coords = "0x0";
      workspaces = [4 5 6];
    }
    {
      name = "HDMI-A-2";
      coords = "2560x660";
      workspaces = [7 8 9];
    }
    {
      name = "DP-2";
      coords = "-1080x50";
      rotation = "1";
      workspaces = [1 2 3];
    }
  ];
}
