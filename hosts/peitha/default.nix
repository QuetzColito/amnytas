{ ... }:
{
    wm = "Hyprland";
    isNvidia = true;
    wantGrub = true;

    system.stateVersion = "23.11"; # Did you read the comment?

    # extra ssd (could be in hardware-configuration.nix too by now)
    fileSystems."/home/quetz/storage" = {
        device = "/dev/sda1";
        options = [ "nofail" ];
    };
}
