{...}:
{
    imports = [ ./hardware-configuration.nix ];

    hostName = "zojja"; # Define your hostname.
    mainUser = "melon"; # Define username
    wm = "Hyprland";
    isNvidia = true;

    system.stateVersion = "23.11"; # Did you read the comment?

}
