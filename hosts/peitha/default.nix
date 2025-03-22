_: {
  wm = "Hyprland";
  isNvidia = false;
  wantGrub = true;

  system.stateVersion = "24.05"; # Did you read the comment?

  fileSystems."/home/quetz/storage" = {
    device = "/dev/sda4";
    options = ["nofail"];
  };
}
