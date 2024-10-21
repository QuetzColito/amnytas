{
    lib,
    ...
}: {

    imports = [ ./arthezia.nix ];

    monitors = lib.mkForce [
        {
            name = "eDP-1";
            coords = "0x0";
            workspaces = [ 1 2 3 4 5 6 7 8 9];
        }
    ];

    home = {
        username = lib.mkForce "arthezia";

        shellAliases = {
            hs = lib.mkForce "home-manager switch --flake ~/amnytas#arthezia-mobile";
            hss = lib.mkForce "home-manager switch --flake ~/amnytas";
        };
    };
}
