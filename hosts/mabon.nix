{pkgs, ...}: let
  isDualMonitor = true;
in {
  isNvidia = true;
  wantGrub = true;
  enableBluetooth = true;
  autostartApps = isDualMonitor;

  system.stateVersion = "23.11"; # Did you read the comment?

  # Optimus prime because laptop
  hardware.nvidia.prime = {
    reverseSync.enable = true;

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  packages = with pkgs; [acpi];

  monitors =
    [
      {
        name = "eDP-1";
        coords = "0x0";
        workspaces =
          if isDualMonitor
          then [1 2 3 7 8 9]
          else [1 2 3 4 5 6 7 8 9];
      }
    ]
    ++ (
      if isDualMonitor
      then [
        {
          name = "HDMI-A-1";
          # config = "HDMI-A-1,1920x1080@119.88Hz,-1920x0,1";
          coords = "-1920x0";
          workspaces = [4 5 6];
        }
      ]
      else []
    );

  services.upower.enable = true;
}
