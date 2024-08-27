{ ... }:
{
    home = {
        username = "melon";
        homeDirectory = "/home/melon";

        stateVersion = "23.11"; # Please read the comment before changing.
    };

    imports = [
        ./home.nix
    ];

    monitors = [
        {
            id = "0";
            name = "HDMI-A-1";
            wallpaper = "~/nixos/wallpaper/side.jpg";
            config = "0x0";
            workspaces = [ 1 2 3 4 5 6 7 8 9 ];
        }
    ];
}
