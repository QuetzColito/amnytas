_: {
  isNvidia = true;
  wantGrub = true;
  enableBluetooth = true;

  system.stateVersion = "23.11"; # Did you read the comment?

  # Optimus prime because laptop
  hardware.nvidia.prime = {
    reverseSync.enable = true;

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  monitors = [
    # {
    #   name = "HDMI-A-1";
    #   coords = "-1920x0";
    #   workspaces = [4 5 6];
    # }
    {
      name = "DP-1";
      coords = "-1920x0";
      workspaces = [4 5 6];
    }
    {
      name = "eDP-1";
      coords = "0x0";
      # workspaces = [1 2 3 4 5 6 7 8 9];
      workspaces = [1 2 3 7 8 9];
    }
  ];

  services.upower.enable = true;
}
