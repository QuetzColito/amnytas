{...}:
{
    imports = [ ./hardware-configuration.nix ];

    hostName = "mabon"; # Define your hostname.
    mainUser = "arthezia"; # Define username
    wm = "Hyprland";
    isNvidia = true;
    wantGrub = true;

    system.stateVersion = "23.11"; # Did you read the comment?

    hardware.nvidia.prime = {
        offload = {
            enable = true;
            enableOffloadCmd = true;
        };

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
    };
}
