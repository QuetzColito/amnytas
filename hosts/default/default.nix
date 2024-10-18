{...}:
{
    wm = "Hyprland"; # Hyprland, Kde, or Cosmic
    # if you need nvidia
    isNvidia = false;
    # if you want the grub config (requires some additional manual work for first setup)
    wantGrub = false;

    system.stateVersion = "23.11";
    # set to the nixpkgs version of your system (look at /etc/nixos/configuration.nix if unsure)
}
