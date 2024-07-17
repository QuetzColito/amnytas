{
  ...
}: {
    imports = [
        ./dev/nixvim
        ./terminal
        ../stylix.nix
    ];

    home = {
        shellAliases = {
            hs = "home-manager switch --flake ~/nixos";
            hn = "home-manager news --flake ~/nixos";
            ns = "sudo nixos-rebuild switch --flake ~/nixos";
        };
        username = "nixos";
        homeDirectory = "/home/nixos";

        stateVersion = "24.05"; # Please read the comment before changing.
    };

    nixpkgs.config.allowUnfree = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
