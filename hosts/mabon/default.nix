{...}:
{
    wm = "Hyprland";
    isNvidia = true;
    wantGrub = true;

    system.stateVersion = "23.11"; # Did you read the comment?

    # Optimus prime because laptop
    hardware.nvidia.prime = {
        offload = {
            enable = true;
            enableOffloadCmd = true;
        };

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
    };
}
