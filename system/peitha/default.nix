{ ... }:
{
    hostName = "peitha"; # Define your hostname.
    mainUser = "quetz"; # Define username
    wm = "Hyprland";
    isNvidia = true;
    wantGrub = true;

    system.stateVersion = "23.11"; # Did you read the comment?

    fileSystems."/home/quetz/storage" = {
        device = "/dev/sda1";
        options = [ "nofail" ];
    };
}
