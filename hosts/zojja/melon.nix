{...}: {
  home = {
    stateVersion = "23.11"; # Please read the comment before changing.
  };

  monitors = [
    {
      name = "HDMI-A-1";
      coords = "0x0";
      workspaces = [1 2 3 4 5 6 7 8 9];
    }
  ];
}
