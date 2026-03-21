_: {
  isNvidia = true;
  wantLimine = true;
  enableBluetooth = true;

  system.stateVersion = "23.11"; # Did you read the comment?

  # Optimus prime because laptop
  hardware.nvidia.prime = {
    reverseSync.enable = true;

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  services.upower.enable = true;
}
