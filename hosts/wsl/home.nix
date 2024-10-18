{
  inputs,
  ...
}: {
    imports = [
        ./dev/nixvim
        ./terminal
        ../../stylix.nix inputs.stylix.homeManagerModules.stylix
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

    programs.git.extraConfig.user = {
        email = "stefan.lahne@proton.me";
        name = "Stefan Lahne";
    };


    nixpkgs.config.allowUnfree = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
