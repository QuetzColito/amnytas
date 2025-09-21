_: {
  wantGrub = true;
  enableBluetooth = true;

  system.stateVersion = "25.11"; # Did you read the comment?
  virtualisation.waydroid.enable = true;

  monitors = [];

  services.upower.enable = true;
}
