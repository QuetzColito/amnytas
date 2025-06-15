_: {
  isNvidia = false;
  wantGrub = true;

  system.stateVersion = "25.05"; # Did you read the comment?

  autostartApps = true;

  monitors = [
    {
      name = "DP-4";
      coords = "0x0";
      workspaces = [4 5 6];
    }
    {
      name = "DP-5";
      coords = "2560x660";
      workspaces = [1 2 3 7 8 9];
    }
    # {
    #   name = "DP-2";
    #   coords = "-1080x50";
    #   rotation = "1";
    #   workspaces = [1 2 3];
    # }
  ];
}
